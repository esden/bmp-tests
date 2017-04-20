CROSS_COMPILE = arm-none-eabi-
LDFLAGS += --specs=nosys.specs

SRC += ../cortexm/vectors.c

include ../generic/Makefile.inc

