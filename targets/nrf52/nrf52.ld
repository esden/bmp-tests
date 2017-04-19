MEMORY
{
	rom (rx) : ORIGIN = 0x00000000, LENGTH = 4K 
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 16K
}

INCLUDE ../generic/generic.ld

