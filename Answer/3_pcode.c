// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_main(){
// entering function block 
LOADF(1.000000)
LOADF(2.200000)
LOADF(3.500000)
MULTF
ADDF
return;
//Exiting function block, removing loc var and arg from TDS
}
