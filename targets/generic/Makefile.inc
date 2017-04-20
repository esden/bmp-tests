CC = $(CROSS_COMPILE)gcc
CFLAGS += -Wall -Wextra -O0 -g3 --std=gnu99
LDFLAGS += -nostartfiles

SRC += ../generic/main.c

test.elf: $(SRC:.c=.o)
	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean:
	-rm test.elf
