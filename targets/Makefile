ifneq ($(V), 1)
MFLAGS += --no-print-dir --silent
Q := @
endif

.DEFAULT_GOAL = test.elf

%:
	$(Q)for mdir in */Makefile; do \
		echo "  MAKE   " `dirname $$mdir` $@ ;\
		$(MAKE) $(MFLAGS) -C `dirname $$mdir` $@ ;\
	done

