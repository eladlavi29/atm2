#include <asm/desc.h>

void my_store_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
    asm("SIDT (%rdi)");
// </STUDENT FILL>
}

void my_load_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
    asm("LIDT (%rdi)");
// <STUDENT FILL>
}

void my_set_gate_offset(gate_desc *gate, unsigned long addr) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
    unsigned short low = addr & 0xFFFF;                // Extracting the low segment (16 low bits)
    unsigned short medium = (addr >> 16) & 0xFFFF;     // Extracting the medium segment (16 middle bits)
    unsigned long high = addr >> 32;                   // Extracting the high segment (32 last bits)

    gate->offset_low =  low;
    gate->offset_middle = medium;
    gate->offset_high = high;
// </STUDENT FILL>
}

unsigned long my_get_gate_offset(gate_desc *gate) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
    unsigned long high = gate->offset_high;
    unsigned long medium = gate->offset_middle;
    unsigned long low = gate->offset_low;
    return ((high << 32) | (medium << 16) | low);
// </STUDENT FILL>
}
