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
    final_content = "1 0 0 1 50 770 cm BT /F0 36 Tf (%s) Tj ET" % content
    hex_bytes = hexlify(final_content.encode('utf-8')).upper().decode('ascii')
    output = ' '.join(
        [hex_bytes[2 * i:2 * i + 2] for i in range(len(hex_bytes) // 2)])
    print("Original:", content)
    print("Wrapped:", final_content)
    print("Copy:", output)
    print("Length:", len(output))
