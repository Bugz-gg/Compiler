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
LOADI(0)

void pcode_main(){
// entering function block 
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
LOADF(0.000000)
GTF
IFN(False_0)
LOADI(1)
STOREP(1) //storing y value
GOTO(End_0)
False_0:
LOADI(0)
STOREP(1) //storing y value
End_0:
//Exiting function block, removing loc var and arg from TDS
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
return;
}
