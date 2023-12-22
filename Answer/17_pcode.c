// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_castToFloat(){
// entering function block 
// Argument x of function plus in TDS with offset -1
LOADP(bp + -1) //Loading x value
return;
//Exiting function block, removing loc var and arg from TDS
}
void pcode_main(){
// entering function block 
// loading function castToFloat arguments
LOADI(1)
I2F
SAVEBP
CALL(pcode_castToFloat)
RESTORESP
ENDCALL(1)
return;
//Exiting function block, removing loc var and arg from TDS
}
