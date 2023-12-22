// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

void pcode_main(){
// entering function block 
// Declare x of type int with offset 1 at depth 1
LOADI(0)

LOADI(3)
STOREP(bp + 1) //storing x value
//Exiting function block, removing loc var and arg from TDS
SAVEBP // entering block
// Declare y of type int with offset 1 at depth 2
LOADI(0)

// Argument x of function plus in TDS with offset 1
LOADP(stack[bp] + 1) //Loading x value
STOREP(bp + 1) //storing y value
//Exiting function block, removing loc var and arg from TDS
SAVEBP // entering block
// Declare z of type int with offset 1 at depth 3
LOADI(0)

// Argument x of function plus in TDS with offset 1
LOADP(stack[stack[bp]] + 1) //Loading x value
STOREP(bp + 1) //storing z value
//Exiting function block, removing loc var and arg from TDS
RESTOREBP // exiting block
RESTOREBP // exiting block
LOADI(1)
return;
}
