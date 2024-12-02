
function(create_compile_flags_library)
    message(STATUS "Creating common compilation flag library")
    if(NOT DEFINED ARDUINO_MCU)
        message(FATAL_ERROR "Arduino board variables missing: ARDUINO_MCU not set")
    endif()

    if(NOT DEFINED  ARDUINO_F_CPU)
        message(FATAL_ERROR "Arduino board variables missing: ARDUINO_F_CPU not set")
    endif()

    if(NOT DEFINED  ARDUINO_VERSION)
        message(FATAL_ERROR "Arduino board variables missing: ARDUINO_VERSION not set")
    endif()

    if(NOT DEFINED  ARDUINO_BOARD)
        message(FATAL_ERROR "Arduino board variables missing: ARDUINO_BOARD not set")
    endif()

    message(VERBOSE "Adding interface library 'arduino_CompileFlags'")
    add_library(arduino_CompileFlags INTERFACE)

    message(VERBOSE "Settings compile options on 'arduino_CompileFlags'")
    message(VERBOSE "Debug mcu: ${ARDUINO_MCU}")
    target_compile_options(arduino_CompileFlags INTERFACE
        "-fno-exceptions"
        "-fno-exceptions"
        "-ffunction-sections"
        "-fdata-sections"
        "$<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>"
        "-mmcu=${ARDUINO_MCU}"
    )

    target_compile_definitions(arduino_CompileFlags INTERFACE
        "F_CPU=${ARDUINO_F_CPU}"
        "ARDUINO=${ARDUINO_VERSION}"
        "ARDUINO_${ARDUINO_BOARD}"
        "ARDUINO_ARCH_AVR"
    )

    target_link_options(arduino_CompileFlags INTERFACE
        "-mmcu=${ARDUINO_MCU}"
        "-fuse-linker-plugin"
        "LINKER:--gc-sections"
    )
    target_compile_features(arduino_CompileFlags INTERFACE cxx_std_11 c_std_11)
    message(STATUS "Successfully created library arduino_CompileFlags.")
endfunction()