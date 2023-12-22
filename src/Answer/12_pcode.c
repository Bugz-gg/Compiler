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
// Declare x of type int with offset 1 at depth 2
LOADI(0)

LOADI(4)
STOREP(bp + 1) //storing x value
//Exiting function block, removing loc var and arg from TDS
SAVEBP // entering block
// Declare x of type int with offset 1 at depth 3
LOADI(0)

LOADI(5)
STOREP(bp + 1) //storing x value
//Exiting function block, removing loc var and arg from TDS
RESTOREBP // exiting block
RESTOREBP // exiting block
LOADI(1)
return;
}
