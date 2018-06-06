#!/usr/bin/env python

import sys
import binascii

def chunks(l, n):
    for i in range(0, len(l), n):
        yield l[i:i + n]

if len(sys.argv) != 2:
    print("Usage: " + sys.argv[0] + " filename")
else:
    with open(sys.argv[1], "rb") as binary_input:
        data = binary_input.read()

        output_text = ""
        for line in chunks(data, 2):
            print(line)
            for byte in line:
                print("%02x"%byte)
                output_text += "{0:08b}".format(byte)
            output_text += "\n"

        output_file = sys.argv[1] + ".txt"
        with open(output_file, "w") as txt_output:
            txt_output.write(output_text)
            txt_output.close()

        binary_input.close()
