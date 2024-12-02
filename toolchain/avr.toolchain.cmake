# Enter CMake cross-compilation mode
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR avr)

message(STATUS "Including AVR Toolchain")
# User settings with sensible defaults
set(ARDUINO_PATH "$ENV{LOCALAPPDATA}/arduino15/packages/arduino" CACHE PATH
    "Path of the Arduino packages folder, e.g. ~/.arduino15/packages/arduino.")
set(AVR_GCC_VERSION "7.3.0-atmel3.6.1-arduino7" CACHE STRING
    "Full version string of the GCC release shipped with the Arduino core.")
set(AVRDUDE_VERSION "6.3.0-arduino17" CACHE STRING
    "Full version string of the avrdude release shipped with the Arduino core.")

# Set variables from environment if provided 
if(DEFINED ENV{ARDUINO_PATH})
    set(_ARDUINO_PACKAGE_PATH_ "$ENV{ARDUINO_PATH}")
else()
    set(_ARDUINO_PACKAGE_PATH_ "${ARDUINO_PATH}")
endif()

if(DEFINED ENV{AVR_GCC_VERSION})
    set(_ARDUINO_AVR_GCC_VER_ "$ENV{AVR_GCC_VERSION}")
else()
    set(_ARDUINO_AVR_GCC_VER_ "${AVR_GCC_VERSION}")
endif()

if(DEFINED ENV{AVRDUDE_VERSION})
    set(_ARDUINO_AVRDUDE_VER_ "$ENV{AVRDUDE_VERSION}")
else()
    set(_ARDUINO_AVRDUDE_VER_ "${AVRDUDE_VERSION}")
endif()

# Set avrdude paths from environment, cache, or derive
if (DEFINED ENV{AVRDUDE_PATH})
    set (_ARDUINO_AVRDUDE_PATH_ "$ENV{AVRDUDE_PATH}")
elseif (DEFINED CACHE{AVRDUDE_PATH})
    set (_ARDUINO_AVRDUDE_PATH_ "${AVRDUDE_PATH}")
else()
    set (_ARDUINO_AVRDUDE_PATH_ ${ARDUINO_PATH}/tools/avrdude/${AVRDUDE_VERSION})
endif()

# Set avrdude paths from environment, cache, or derive
if (DEFINED ENV{AVRDUDE_CONF})
    set (_ARDUINO_AVRDUDE_CONF_ "$ENV{AVRDUDE_CONF}")
elseif (DEFINED CACHE{AVRDUDE_CONF})
    set (_ARDUINO_AVRDUDE_CONF_ "${AVRDUDE_CONF}")
else()
    set (_ARDUINO_AVRDUDE_CONF_ ${_ARDUINO_AVRDUDE_PATH_}/etc/avrdude.conf)
endif()

#Set Toolchain Paths from the environment, cache, or derive
if (DEFINED ENV{AVR_TOOLCHAIN_PATH})
    set (ARDUINO_AVR_TOOLS_PATH "$ENV{AVR_TOOLCHAIN_PATH}")
elseif (DEFINED CACHE{AVR_TOOLCHAIN_PATH})
    set (ARDUINO_AVR_TOOLS_PATH "${AVR_TOOLCHAIN_PATH}")
else()
    set (ARDUINO_AVR_TOOLS_PATH ${ARDUINO_PATH}/tools/avr-gcc/${AVR_GCC_VERSION}/bin)
endif()

# Toolchain paths
if(CMAKE_HOST_WIN32)
    set(CMAKE_C_COMPILER ${ARDUINO_AVR_TOOLS_PATH}/avr-gcc.exe CACHE FILEPATH
    "Path to avr-gcc" FORCE)
    set(CMAKE_CXX_COMPILER ${ARDUINO_AVR_TOOLS_PATH}/avr-g++.exe CACHE FILEPATH
    "Path to avr-g++" FORCE)
    set(CMAKE_OBJCOPY ${ARDUINO_AVR_TOOLS_PATH}/avr-objcopy.exe CACHE FILEPATH
    "Path to avr-objcopy" FORCE)
    set(CMAKE_OBJDUMP ${ARDUINO_AVR_TOOLS_PATH}/avr-objdump.exe CACHE FILEPATH
    "   Path to avr-objdump" FORCE)
    set(CMAKE_SIZE ${ARDUINO_AVR_TOOLS_PATH}/avr-size.exe CACHE FILEPATH
    "Path to avr-size" FORCE)
    set(_ARDUINO_AVRDUDE_BIN_ ${_ARDUINO_AVRDUDE_PATH_}/bin/avrdude.exe CACHE FILEPATH
    "Path to avrdude" FORCE)
else()
    set(CMAKE_C_COMPILER ${ARDUINO_AVR_TOOLS_PATH}/avr-gcc CACHE FILEPATH
        "Path to avr-gcc" FORCE)
    set(CMAKE_CXX_COMPILER ${ARDUINO_AVR_TOOLS_PATH}/avr-g++ CACHE FILEPATH
        "Path to avr-g++" FORCE)
    set(CMAKE_OBJCOPY ${ARDUINO_AVR_TOOLS_PATH}/avr-objcopy CACHE FILEPATH
        "Path to avr-objcopy" FORCE)
    set(CMAKE_OBJDUMP ${ARDUINO_AVR_TOOLS_PATH}/avr-objdump CACHE FILEPATH
        "Path to avr-objdump" FORCE)
    set(CMAKE_SIZE ${ARDUINO_AVR_TOOLS_PATH}/avr-size CACHE FILEPATH
        "Path to avr-size" FORCE)
    set(_ARDUINO_AVRDUDE_BIN_ ${_ARDUINO_AVRDUDE_PATH_}/bin/avrdude CACHE FILEPATH
        "Path to avrdude" FORCE)
endif()

# Only look libraries etc. in the sysroot, but never look there for programs
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_C_FLAGS_DEBUG "-Og -g -DDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g -DDEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-Os -g -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-Os -g -DNDEBUG")
set(CMAKE_C_FLAGS_MINSIZEREL "-Os -g0 -DNDEBUG")
set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -g0 -DNDEBUG")

