CC = $(CROSS_COMPILE)gcc
CFLAGS += -Wall -Wextra -O0 -g3 --std=gnu99
LDFLAGS += -nostartfiles

test.elf: ../generic/main.c ../cortexm/vectors.c
	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean:
	-rm test.elf
