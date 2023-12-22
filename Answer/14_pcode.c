// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_plusUn(){
// entering function block 
// Argument x of function plus in TDS with offset -1
LOADP(bp + -1) //Loading x value
LOADI(1)
ADDI
return;
//Exiting function block, removing loc var and arg from TDS
}
void pcode_main(){
// entering function block 
// loading function plusUn arguments
LOADI(1)
SAVEBP
CALL(pcode_plusUn)
RESTORESP
ENDCALL(1)
return;
//Exiting function block, removing loc var and arg from TDS
}
