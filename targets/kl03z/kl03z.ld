MEMORY
{
	rom (rx) : ORIGIN = 0x00000000, LENGTH = 32K 
	ram (rwx) : ORIGIN = 0x1ffffe00, LENGTH = 2K
}

INCLUDE ../generic/generic.ld

