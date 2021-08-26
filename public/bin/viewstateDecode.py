#!/usr/bin/env python3
# a simple Windows ViewState decoder
import sys
import urllib.parse
import base64
import string

sys.path.append('.')
from viewstate import ViewState

urlEncodedViewState = sys.argv[1]
b64EncodedViewState = urllib.parse.unquote(urlEncodedViewState)

vs = ViewState(b64EncodedViewState)
viewStateBytes = vs.body

print("\nViewState:\n", viewStateBytes)
