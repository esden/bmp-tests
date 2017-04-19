EXTERN(vector_table)
ENTRY(reset_handler)

SECTIONS
{
    .int : {
        *(.vectors)
    } >m_int
    .fconf : {
        KEEP(*(.FlashConfig))
    } >m_fconf
    .text : {
        *(.text*)
        . = ALIGN(4);
        *(.rodata*)
        . = ALIGN(4);
    } >rom
    . = ALIGN(4);
    _etext = .;

    .data : {
        _data = .;
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >ram AT >rom
    _data_loadaddr = LOADADDR(.data);

    .bss : {
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } >ram

    . = ALIGN(4);
    end = .;
}

PROVIDE(_stack = ORIGIN(ram) + LENGTH(ram));
