#!/usr/bin/env python3
"""
Download an IPA referenced by an itms-services OTA install URL.

Usage:
  python fetch_ipa_from_itms.py "itms-services://?action=download-manifest&url=..."

Notes:
- The manifest and IPA links are often time-limited (e.g., signed S3 URLs).
- This script:
  1) extracts + URL-decodes the manifest URL
  2) downloads the manifest plist
  3) parses it to find the software-package (IPA) URL
  4) downloads the IPA
"""

from __future__ import annotations

import os
import re
import sys
import plistlib
import urllib.parse
import urllib.request
from typing import Optional


def extract_manifest_url(itms_url: str) -> str:
    """
    Extract the 'url' query param from an itms-services link and URL-decode it.
    """
    # Accept either itms-services://?... or a raw https manifest url
    if itms_url.startswith("http://") or itms_url.startswith("https://"):
        return itms_url

    parsed = urllib.parse.urlparse(itms_url)
    if parsed.scheme != "itms-services":
        raise ValueError(f"Expected itms-services:// URL, got scheme={parsed.scheme!r}")

    qs = urllib.parse.parse_qs(parsed.query, keep_blank_values=True)
    if "url" not in qs or not qs["url"]:
        raise ValueError("Missing 'url' query parameter in itms-services link")

    # parse_qs already percent-decodes once, but the value may still contain escapes;
    # run unquote again to be safe.
    manifest_url = qs["url"][0]
    manifest_url = urllib.parse.unquote(manifest_url)
    return manifest_url


def download_bytes(url: str, timeout: int = 60) -> bytes:
    """
    Download content from a URL, following redirects.
    """
    req = urllib.request.Request(
        url,
        headers={
            # Some endpoints behave better with a UA. Nothing fancy.
            "User-Agent": "fetch_ipa_from_itms/1.0",
        },
        method="GET",
    )
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def parse_ipa_url_from_manifest(plist_bytes: bytes) -> str:
    """
    Parse the manifest plist and return the 'software-package' asset URL (the IPA).
    """
    try:
        manifest = plistlib.loads(plist_bytes)
    except Exception:
        # Sometimes a server returns HTML/XML error pages; try to give a better hint.
        sample = plist_bytes[:400].decode("utf-8", errors="replace")
        raise ValueError(f"Failed to parse plist. First bytes:\n{sample}")

    items = manifest.get("items")
    if not isinstance(items, list):
        raise ValueError("Manifest plist missing top-level 'items' array")

    for item in items:
        if not isinstance(item, dict):
            continue
        assets = item.get("assets", [])
        if not isinstance(assets, list):
            continue
        for asset in assets:
            if not isinstance(asset, dict):
                continue
            if asset.get("kind") == "software-package" and isinstance(asset.get("url"), str):
                return asset["url"]

    raise ValueError("No software-package asset URL found in manifest plist")


def safe_filename_from_url(url: str, default: str) -> str:
    """
    Try to derive a reasonable filename from the URL path; fallback to default.
    """
    path = urllib.parse.urlparse(url).path
    name = os.path.basename(path)
    if name.lower().endswith(".ipa"):
        return name
    return default


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print('Usage: python fetch_ipa_from_itms.py "itms-services://?action=download-manifest&url=..."')
        return 2

    itms_link = argv[1].strip()
    out_dir = argv[2].strip() if len(argv) >= 3 else "."

    manifest_url = extract_manifest_url(itms_link)
    print(f"[+] Manifest URL:\n    {manifest_url}")

    print("[+] Downloading manifest plist...")
    manifest_bytes = download_bytes(manifest_url)
    manifest_path = os.path.join(out_dir, "manifest.plist")
    os.makedirs(out_dir, exist_ok=True)
    with open(manifest_path, "wb") as f:
        f.write(manifest_bytes)
    print(f"    Saved: {manifest_path}")

    ipa_url = parse_ipa_url_from_manifest(manifest_bytes)
    print(f"[+] IPA URL:\n    {ipa_url}")

    ipa_name = safe_filename_from_url(ipa_url, default="app.ipa")
    ipa_path = os.path.join(out_dir, ipa_name)

    print("[+] Downloading IPA (this can be large)...")
    ipa_bytes = download_bytes(ipa_url, timeout=300)
    with open(ipa_path, "wb") as f:
        f.write(ipa_bytes)
    print(f"    Saved: {ipa_path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))

