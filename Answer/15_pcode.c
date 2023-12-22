// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_plus(){
// entering function block 
// Argument x of function plus in TDS with offset -2
LOADP(bp + -2) //Loading x value
// Argument y of function plus in TDS with offset -1
LOADP(bp + -1) //Loading y value
ADDI
return;
//Exiting function block, removing loc var and arg from TDS
}
void pcode_main(){
// entering function block 
// loading function plus arguments
LOADI(5)
LOADI(6)
SAVEBP
CALL(pcode_plus)
RESTORESP
ENDCALL(2)
return;
//Exiting function block, removing loc var and arg from TDS
}
