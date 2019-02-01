#!/usr/bin/env python2

from lib.core.data import kb
from lib.core.enums import PRIORITY
import string

__priority__ = PRIORITY.NORMAL

def dependencies():
    pass

def tamper(payload, **kwargs):
    orig = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    srvr = "NOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM"
    return payload.translate(string.maketrans(orig,srvr))
