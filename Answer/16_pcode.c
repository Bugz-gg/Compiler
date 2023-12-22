// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_fact(){
// entering function block 
// Argument x of function plus in TDS with offset -1
LOADP(bp + -1) //Loading x value
LOADI(1)
LTI
IFN(False_0)
LOADI(1)
return;
GOTO(End_0)
False_0:
// Argument x of function plus in TDS with offset -1
LOADP(bp + -1) //Loading x value
// loading function fact arguments
// Argument x of function plus in TDS with offset -1
LOADP(bp + -1) //Loading x value
LOADI(1)
SUBI
SAVEBP
CALL(pcode_fact)
RESTORESP
ENDCALL(1)
MULTI
return;
End_0:
//Exiting function block, removing loc var and arg from TDS
}
void pcode_main(){
// entering function block 
// loading function fact arguments
LOADI(5)
SAVEBP
CALL(pcode_fact)
RESTORESP
ENDCALL(1)
return;
//Exiting function block, removing loc var and arg from TDS
}
