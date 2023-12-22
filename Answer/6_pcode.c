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
LOADF(0.0)

void pcode_main(){
// entering function block 
LOADI(3)
STOREP(0) //storing x value
//Exiting function block, removing loc var and arg from TDS
LOADF(2.000000)
STOREP(1) //storing y value
LOADI(1)
// Argument y of function plus in TDS with offset 1
LOADP(1) //Loading y value
// Argument x of function plus in TDS with offset 0
LOADP(0) //Loading x value
MULTF
I2F2 // converting the first argument to float
I2F // converting the second argument to float
ADDF
return;
}
