MEMORY
{
	rom (rx) : ORIGIN = 0x00000000, LENGTH = 16K
	ram (rwx) : ORIGIN = 0x10000000, LENGTH = 4K
}

INCLUDE ../generic/generic.ld

