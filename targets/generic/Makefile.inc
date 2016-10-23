CC = $(CROSS_COMPILE)gcc
LDFLAGS += -nostartfiles

test.elf: ../generic/main.c ../cortexm/vectors.c
	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean:
	-rm test.elf
