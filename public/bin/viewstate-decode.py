#!/usr/bin/env python3
import sys
import urllib.parse
import base64
import string

sys.path.append('/Users/json/Documents/lib/python')
from viewstate import ViewState

urlEncodedViewState = sys.argv[1]
b64EncodedViewState = urllib.parse.unquote(urlEncodedViewState)

vs = ViewState(b64EncodedViewState)
viewStateBytes = vs.body

print("\nViewState:\n", viewStateBytes)
