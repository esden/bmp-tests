#include <stdint.h>

extern uint8_t _data_loadaddr, _data, _edata, _ebss, _stack;

void reset_handler(void);
void reset_handler(void);
void nmi_handler(void);
void hard_fault_handler(void);
void mem_manage_handler(void);
void bus_fault_handler(void);
void usage_fault_handler(void);
void debug_monitor_handler(void);
void sv_call_handler(void);
void pend_sv_handler(void);
void sys_tick_handler(void);

int main(void);

__attribute__ ((section(".vectors")))
void * vector_table[] = {
        &_stack,
        reset_handler,
        nmi_handler,
        hard_fault_handler,
        mem_manage_handler,
        bus_fault_handler,
        usage_fault_handler,
        debug_monitor_handler,
        sv_call_handler,
        pend_sv_handler,
        sys_tick_handler,
};

void _unhandled_exception(void)
{
        while (1);
}

#pragma weak nmi_handler = _unhandled_exception
#pragma weak hard_fault_handler = _unhandled_exception
#pragma weak sv_call_handler = _unhandled_exception
#pragma weak pend_sv_handler = _unhandled_exception
#pragma weak sys_tick_handler = _unhandled_exception
#pragma weak mem_manage_handler = _unhandled_exception
#pragma weak bus_fault_handler = _unhandled_exception
#pragma weak usage_fault_handler = _unhandled_exception
#pragma weak debug_monitor_handler = _unhandled_exception

void __attribute__((naked)) reset_handler(void)
{
        __builtin_memcpy(&_data, &_data_loadaddr, &_edata - &_data);
        __builtin_memset(&_edata, 0, &_ebss - &_edata);
        main();
}
