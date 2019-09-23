#!/usr/bin/env python3

import sys
from binascii import hexlify

if __name__ == '__main__':
    if len(sys.argv) == 1:
        content = sys.stdin.readlines()
        content = ''.join(content)
    elif len(sys.argv) == 2:
        content = sys.argv[1]
    else:
        raise Exception("Pass 0 or 1 arguments only!")
    hex_bytes = hexlify(content.encode('utf-8')).upper().decode('ascii')
    print(' '.join(
        [hex_bytes[2 * i:2 * i + 2] for i in range(len(hex_bytes) // 2)]))
