void board_init(void)
{
	*(unsigned short*)0x4005200E = 0xC520;
	*(unsigned short*)0x4005200E = 0xD928;
	asm("nop");
	*(unsigned short*)0x40052000 &= ~1;
}

