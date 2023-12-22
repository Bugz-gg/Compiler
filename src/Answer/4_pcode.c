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
LOADF(2.200000)
LOADI(3)
MULTF
I2F2 // converting the first argument to float
I2F // converting the second argument to float
ADDF
return;
//Exiting function block, removing loc var and arg from TDS
}
