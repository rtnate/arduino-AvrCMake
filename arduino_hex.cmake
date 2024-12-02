# Transforms the target.elf file into target.eep (EEPROM) and target.hex files.
# Also prints the size of each section in target.elf.
function(create_hex_on_build target)
    set_target_properties(${target} PROPERTIES SUFFIX ".elf")
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_SIZE} ARGS 
            -A "$<TARGET_FILE:${target}>"
        USES_TERMINAL)
    add_custom_command(TARGET ${target} POST_BUILD
        BYPRODUCTS ${target}.eep
        COMMAND ${CMAKE_OBJCOPY} ARGS 
            -O ihex -j .eeprom
            --set-section-flags=.eeprom=alloc,load
            --no-change-warnings --change-section-lma 
            .eeprom=0
            "$<TARGET_FILE:${target}>"
            ${target}.eep)
    add_custom_command(TARGET ${target} POST_BUILD
        BYPRODUCTS ${target}.hex
        COMMAND ${CMAKE_OBJCOPY} ARGS 
            -O ihex -R .eeprom
            "$<TARGET_FILE:${target}>"
            ${target}.hex)
    add_custom_command(TARGET ${target} POST_BUILD
        BYPRODUCTS ${target}.map
        COMMAND ${CMAKE_OBJDUMP} ARGS 
            -t
            "$<TARGET_FILE:${target}>" > 
            ${target}.map)
    add_custom_command(TARGET ${target} POST_BUILD
        BYPRODUCTS ${target}.lss
        COMMAND ${CMAKE_OBJDUMP} ARGS 
        -S
        "$<TARGET_FILE:${target}>" > 
        ${target}.lss)
endfunction()