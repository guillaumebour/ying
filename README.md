# Ying Is Next Gen (Ying)

Ying is a microcontroller based on a 16 bits RISC microprocessor with a 5-stage pipeline.   
It was designed to run C code compiled with the [yang](https://www.github.com/guillaumebour/yang) compiler. 

This code is written in VHDL and can be synthesized using [GHDL](https://github.com/ghdl/ghdl).  

## Functionalities

Some of Ying's functionalities include support for:
- arithmetic operations
- registers setting / copying / loading / storing operations
- loading RAM from file (*totxt* tool can be used to transfrom binary to txt format)

## Usage

To synthetize a specific component and run its tests:
```
~/ying $ make TEST=pipeline
```

To synthetize ying and run its tests:
```
~/ying $ make TEST=ying
```

To transform a binary into a "txt-binary" file:
```
~/ying/data $ python3 totxt.py binary_file
```
This will output a *binary_file.txt* readable by the RAM component.

## Requirements

GTKWave is used to visualize the digital timing diagrams.
