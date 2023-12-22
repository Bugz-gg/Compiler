// PCode Header
#include "PCode.h"

int main() {
pcode_main();
printf("%d\n",stack[sp-1].int_value);
return stack[sp-1].int_value;
}

// Declare x of type int with offset 0 at depth 0
LOADI(0)

void pcode_main(){
// entering function block 
LOADI(3)
STOREP(0) //storing x value
//Exiting function block, removing loc var and arg from TDS
LOADI(1)
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
ADDI
return;
}
