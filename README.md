# Arduino AVR CMake Scripts

Compile Arduino AVR Sketches using CMake

## Basic Usage 

```
cmake_minimum_required(VERSION 3.23)
# Change to your project name (sketch name or similar)
project(MyArduinoProject LANGUAGES C CXX ASM)

add_arduino_board("Arduino Nano")
add_arduino_sketch("MySketch" /patch/to/arduino/core)

target_sources("MySketch" PRIVATE
    src/Sketch.cpp
)

include_arduino_library("Wire")
```
