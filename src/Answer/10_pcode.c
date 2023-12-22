// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

// Declare x of type int with offset 0 at depth 0
LOADI(0)

// Declare y of type int with offset 1 at depth 0
LOADI(0)

// Declare z of type int with offset 2 at depth 0
LOADI(0)

void pcode_main(){
// entering function block 
LOADI(3)
STOREP(0) //storing x value
//Exiting function block, removing loc var and arg from TDS
LOADI(5)
STOREP(1) //storing y value
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
STOREP(2) //storing z value
StartLoop_0
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
LOADI(0)
GTI
IFN(EndLoop_0)
SAVEBP // entering block
StartLoop_1
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
LOADI(0)
GTI
IFN(EndLoop_1)
SAVEBP // entering block
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
LOADI(1)
SUBI
STOREP(1) //storing y value
//Exiting function block, removing loc var and arg from TDS
// Argument z of function plus in TDS with offset 2
LOADP(2) //Loading z value
LOADI(1)
ADDI
STOREP(2) //storing z value
RESTOREBP // exiting block
GOTO(StartLoop_1)
EndLoop_1:
//Exiting function block, removing loc var and arg from TDS
// Argument z of function plus in TDS with offset 2
LOADP(2) //Loading z value
STOREP(1) //storing y value
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
LOADI(1)
SUBI
STOREP(0) //storing x value
RESTOREBP // exiting block
GOTO(StartLoop_0)
EndLoop_0:
// Argument z of function plus in TDS with offset 2
LOADP(2) //Loading z value
return;
}
