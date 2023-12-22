%{

#include "Table_des_symboles.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
  
extern int yylex();
extern int yyparse();

void yyerror (char* s) {
  printf ("%s\n",s);
  exit(0);
  }
		
 int depth=0; // block depth
 


%}

%union { 
  struct ATTRIBUTE * symbol_value;
  char * string_value;
  int int_value;
  float float_value;
  int type_value;
  int label_value;
  int offset_value;  
}

%token <int_value> NUM
%token <float_value> DEC


%token INT FLOAT VOID

%token <string_value> ID
%token AO AF PO PF PV VIR
%token RETURN  EQ
%token <label_value> IF ELSE WHILE

%token <label_value> AND OR NOT DIFF EQUAL SUP INF
%token PLUS MOINS STAR DIV
%token DOT ARR

%nonassoc IFX
%left OR                       // higher priority on ||
%left AND                      // higher priority on &&
%left DIFF EQUAL SUP INF       // higher priority on comparison
%left PLUS MOINS               // higher priority on + - 
%left STAR DIV                 // higher priority on * /
%left DOT ARR                  // higher priority on . and -> 
%nonassoc UNA                  // highest priority on unary operator
%nonassoc ELSE


%{
char * type2string (int c) {
  switch (c)
    {
    case INT:
      return("int");
    case FLOAT:
      return("float");
    case VOID:
      return("void");
    default:
      return("type error");
    }  
};

  
int checkAndPrintI2F(char * op, int exp1, int exp2) {
    if (exp1 == INT && exp2 == INT) {
        printf("%sI\n", op);
        return INT;
    } else {
        if (exp1 == INT) {
          printf("I2F2 // converting the first argument to float\n");
        }
        if (exp1 == INT) {
            printf("I2F // converting the second argument to float\n");
        }
        printf("%sF\n", op);
        return FLOAT;
    }
}

int label_counter = 0;
int nb_args = 0;
int func_offset = -1;
int next_label() {
    return label_counter++;
}

int previous_label() {
    return --label_counter;
}

#include <stdio.h>
#include <string.h>

// Assuming depth is declared as a global variable
int depth;

void print_load_blocs(int offset, char *name, int sdepth) {
    if (sdepth == 0){
      printf("LOADP(%d) //Loading %s value\n", offset, name);
    }
    else if (sdepth == depth) {
        printf("LOADP(bp + %d) //Loading %s value\n", offset, name);
    } else {
        char head[100] = "LOADP(";
        char tail[100] = "bp";
        while (sdepth < depth) {
            strcat(head, "stack[");
            strcat(tail, "]");
            sdepth++;
        }
        strcat(head, tail);
        printf("%s + %d) //Loading %s value\n", head, offset, name);
    }
}

void print_storep_blocs(int offset, int sdepth, char *name){
  if (sdepth == 0){
      printf("STOREP(%d) //storing %s value\n", offset, name);
    } 
    else if (sdepth == depth) {
      printf("STOREP(bp + %d) //storing %s value\n", offset, name);
    }
    else {
      char head[100] = "STOREP(";
      char tail[100] = "bp";
      while (sdepth != depth) {
        strcat(head, "stack[");
        strcat(tail, "]");
        sdepth++;
      }
      strcat(head, tail);
      printf("%s+ %d) //storing %s value\n", head, offset, name);
    }
}


char *(func_params[10][10]);
int func_params_index = 0;
int params_index = 0;
int find_func_name(char * name) {
    int i = 0;
    while (i < 10) {
      if (strcmp(func_params[i][0], name) == 0) {
          return i;
      }
      i++;
    }
    return -1;
}
  %}

%start prog  

// liste de tous les non terminaux dont vous voulez manipuler l'attribut
%type <type_value> type exp typename params app fun
%type <string_value> fun_head fid
%type <offset_value> decl vlist glob_decl_list var_decl decl_list vir
%type <label_value> if while cond elsop else inst bool_cond while_cond arglist args

 /* Attention, la rêgle de calcul par défaut $$=$1 
    peut créer des demandes/erreurs de type d'attribut */

%%

 // O. Déclaration globale

prog : glob_decl_list              {}

glob_decl_list : glob_decl_list fun {$$ = $1;}
| glob_decl_list decl PV       {$$ = $2;}
|                              {$$ = 0;} // empty glob_decl_list shall be forbidden, but usefull for offset computation

// I. Functions

fun : type fun_head fun_body   {$$ = $1; func_params[func_params_index][params_index] = '\0'; func_params_index++; params_index = 1;}
;

fun_head : ID PO PF            {
  // Pas de déclaration de fonction à l'intérieur de fonctions !
  if (depth>0) yyerror("Function must be declared at top level~!\n");
  set_symbol_value($1, makeSymbol($<type_value>0, -1, depth));
  printf("void pcode_%s()", $1);
  }

| ID PO params PF              {
   // Pas de déclaration de fonction à l'intérieur de fonctions !
  if (depth>0) yyerror("Function must be declared at top level~!\n");
  set_symbol_value($1, makeSymbol($<type_value>0, -1, depth));
  printf("void pcode_%s()", $1);
  func_params[func_params_index][0] = $1;
 }
;

params: type ID vir params     {set_symbol_value($2, makeSymbol($<type_value>1, func_offset--, depth +1)); func_params[func_params_index][++params_index] = $2; params_index++; $$ = $1;} // récursion droite pour numéroter les paramètres du dernier au premier
| type ID                      {set_symbol_value($2, makeSymbol($<type_value>1, func_offset--, depth +1)); func_params[func_params_index][++params_index] = $2; params_index++; $$ = $1;}


vir : VIR                      {}
;

fun_body : fao block faf       {}
;

fao : AO                       {printf("{\n"); printf("// entering function block \n");depth++;}
;
faf : AF                       {printf("}\n");depth--;}
;


// II. Block
block:
decl_list inst_list            {}
;

// III. Declarations

decl_list : decl_list decl PV   {$$ = $2;} 
|                               {$$ = 1;}
;

decl: var_decl                  {$$ = $1;}
;

var_decl : type vlist          {($1 == INT) ? printf("LOADI(0)\n\n") : printf("LOADF(0.0)\n\n"); $$ = $2;}
;

vlist: vlist vir ID            {$$ = $1 + 1;} // récursion gauche pour traiter les variables déclararées de gauche à droite
| ID                           {set_symbol_value($1, makeSymbol($<type_value>0, $<offset_value>-1, depth)); printf("// Declare %s of type int with offset %d at depth %d\n", $1, $<offset_value>-1, depth);$$ = $<offset_value>-1 + 1;}
;

type
: typename                     {$$=$1;}
;

typename
: INT                          {$$=INT;}
| FLOAT                        {$$=FLOAT;}
| VOID                         {$$=VOID;}
;

// IV. Intructions

inst_list: inst_list inst   {} 
| inst                      {printf("//Exiting function block, removing loc var and arg from TDS\n");}
;

pv : PV                       {}
;
 
inst:
ao block af                   {}
| aff pv                      {}
| ret pv                      {printf("return;\n");}
| cond                        {}
| loop                        {}
| pv                          {}
;

// Accolades explicites pour gerer l'entrée et la sortie d'un sous-bloc

ao : AO                       {printf("SAVEBP // entering block\n"); depth++;}
;

af : AF                       {printf("RESTOREBP // exiting block\n"); depth--;}
;


// IV.1 Affectations

aff : ID EQ exp               {attribute syb = get_symbol_value($1); print_storep_blocs(syb->offset, syb->depth, $1);}
;


// IV.2 Return
ret : RETURN exp              {}
| RETURN PO PF                {}
;

// IV.3. Conditionelles
//           N.B. ces rêgles génèrent un conflit déclage reduction
//           qui est résolu comme on le souhaite par un décalage (shift)
//           avec ELSE en entrée (voir y.output)

cond :
if bool_cond inst elsop       { }
;

elsop : else inst              {printf("End_%d:\n", $$);}
|                  %prec IFX   {} // juste un "truc" pour éviter le message de conflit shift / reduce
;

bool_cond : PO exp PF         {$$ = $<label_value>0; printf("IFN(False_%d)\n", $$);}
;

if : IF                        {$$ = next_label();}
;

else : ELSE                   { $$ = $<label_value>-2; printf("GOTO(End_%d)\n", $$); printf("False_%d:\n", $$); }
;

// IV.4. Iterations

loop : while while_cond inst  {printf("GOTO(StartLoop_%d)\n", $1); printf("EndLoop_%d:\n", $1);}
;

while_cond : PO exp PF        {$$ = $<label_value>0; printf("IFN(EndLoop_%d)\n", $$);}

while : WHILE                 { $$ = next_label(); printf("StartLoop_%d\n", $$);}
;


// V. Expressions

exp
// V.1 Exp. arithmetiques
: MOINS exp %prec UNA         {}
         // -x + y lue comme (- x) + y  et pas - (x + y)
| exp PLUS exp                { $$ = checkAndPrintI2F("ADD", $1, $3);}
| exp MOINS exp               { $$ = checkAndPrintI2F("SUB", $1, $3);}
| exp STAR exp                { $$ = checkAndPrintI2F("MULT", $1, $3);}
| exp DIV exp                 { $$ = checkAndPrintI2F("DIV", $1, $3);}
| PO exp PF                   {}
| ID                          {attribute syb = get_symbol_value($1); printf("// Argument %s of function plus in TDS with offset %d\n", $1, syb->offset); print_load_blocs(syb->offset, $1, syb->depth);$$=syb->type;}
| app                         {printf("RESTORESP\n"); printf("ENDCALL(%d)\n", nb_args); nb_args = 0; $$ = $1;}
| NUM                         {printf("LOADI(%d)\n", $1); ;$$=INT;}
| DEC                         {printf("LOADF(%f)\n", $1); $$=FLOAT;}


// V.2. Booléens

| NOT exp %prec UNA           {}
| exp INF exp                 {checkAndPrintI2F("LT", $1, $3); $$ = INT;}
| exp SUP exp                 {checkAndPrintI2F("GT", $1, $3); $$ = INT;}
| exp EQUAL exp               {checkAndPrintI2F("EQ", $1, $3); $$ = INT;}
| exp DIFF exp                {checkAndPrintI2F("DIF", $1, $3); $$ = INT;}
| exp AND exp                 {checkAndPrintI2F("AND", $1, $3); $$ = INT;}
| exp OR exp                  {checkAndPrintI2F("OR", $1, $3); $$ = INT;}

;

// V.3 Applications de fonctions


app : fid PO args PF          {printf("CALL(pcode_%s)\n", $<string_value>1); attribute syb = get_symbol_value($<string_value>1); $$ = syb->type;}
;

fid : ID                      {printf("// loading function %s arguments\n", $1); $$=$1; params_index = 0;} 

args :  arglist               {printf("SAVEBP\n"); params_index = 1;}
|                             {}
;

arglist : arglist VIR exp     {nb_args++;} // récursion gauche pour empiler les arguements de la fonction de gauche à droite
| exp                         {nb_args++; func_params_index = find_func_name($<string_value>-1); attribute syb = get_symbol_value(func_params[func_params_index][params_index]); if (syb->type == FLOAT && $1 == INT) {printf("I2F\n");} else if (syb->type == INT && $1 == FLOAT) {printf("// ERROR CAN'T MAKE AN FLOAT INTO AN INT\n"); return EXIT_FAILURE;}; params_index++;}
;



%% 
int main () {

  /* Ici on peut ouvrir le fichier source, avec les messages 
     d'erreur usuel si besoin, et rediriger l'entrée standard 
     sur ce fichier pour lancer dessus la compilation.
   */

char * header=
"// PCode Header\n\
#include \"PCode.h\"\n\
\n\
int main() {\n\
pcode_main();\n\
printf(\"%d\\n\",stack[sp-1].int_value);\n\
return stack[sp-1].int_value;\n\
}\n";  

 printf("%s\n",header); // ouput header
  
return yyparse ();
 
 
} 

