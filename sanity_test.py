#!python
from __future__ import print_function
import sys
from base64 import b64decode

try:
    import mxnet as mx
    mx.img.imdecode(b64decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==')).asnumpy()
    print('Test succeeded')
except:
    import traceback
    print('Test failed')
    traceback.print_exc()
sys.exit(1)
