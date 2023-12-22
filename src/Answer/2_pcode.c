// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_main(){
// entering function block 
LOADI(1)
LOADI(2)
LOADI(3)
MULTI
ADDI
return;
//Exiting function block, removing loc var and arg from TDS
}
