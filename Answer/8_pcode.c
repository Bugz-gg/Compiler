// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

// Declare x of type int with offset 0 at depth 0
LOADF(0.0)

// Declare y of type int with offset 1 at depth 0
LOADF(0.0)

// Declare z of type int with offset 2 at depth 0
LOADI(0)

void pcode_main(){
// entering function block 
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
LOADF(0.000000)
GTF
IFN(False_0)
SAVEBP // entering block
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
LOADF(0.000000)
GTF
IFN(False_1)
LOADI(1)
STOREP(2) //storing z value
GOTO(End_1)
False_1:
LOADI(2)
STOREP(2) //storing z value
End_1:
//Exiting function block, removing loc var and arg from TDS
RESTOREBP // exiting block
GOTO(End_0)
False_0:
SAVEBP // entering block
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
LOADF(0.000000)
GTF
IFN(False_2)
LOADI(3)
STOREP(2) //storing z value
GOTO(End_2)
False_2:
LOADI(4)
STOREP(2) //storing z value
End_2:
//Exiting function block, removing loc var and arg from TDS
RESTOREBP // exiting block
End_0:
//Exiting function block, removing loc var and arg from TDS
// Argument z of function plus in TDS with offset 2
LOADP(2) //Loading z value
return;
}
