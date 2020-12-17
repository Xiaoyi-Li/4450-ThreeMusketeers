%error-verbose

%{
#include <iostream>
#include "expression.h"
#include "statement.h"
using std::cerr;
using std::endl;

extern int yylex();

void yyerror(const char* s) {
   printf("syntax error on line %s, plz fix it!",s);
}


%}

%union {
   int             intVal;
   float          floatVal;
   char*           ident;
   Statement*      stmt;
   StatementList*  stmtList;
   Expression*     exp;
   ExpressionList* expList;
}

%token<intVal>   INTNUM    "int"
%token<floatVal> FLOATNUM  "float"
%token<ident>    IDENT     "identier"
%token WHILE      "while"
%token DEF        "def"
%token PRINT      "print"
%token RETURN     "return"
%token END        "end"
%token IF         "if"
%token ELSE       "else"
%token GEQUAL     ">="
%token INC        "++"
%token DEC        "--"
%token LEQUAL     "<="
%token EQUAL      "=="
%token NOTEQUAL   "!="
%token PLUSEQUAL  "+="
%token DIVEQUAL   "/="
%token MULTEQUAL  "*="
%token MODEQUAL   "%="
%token POWEQUAL   "^="
%token MINUSEQ    "-="

%type<stmt>      statement
%type<stmtList>  statement_list
%type<exp>       expression
%type<expList>   expression_list
%type<stmt>      if_else
%type<stmt>      print
%type<stmt>      return
%type<stmt>      while
%type<stmt>      assignment


%left '<' LEQUAL '>' GEQUAL EQUAL NOTEQUAL
%left '+' '-'
%left '*' '/' '%' '^'


%%

statement_list  : statement_list statement
                     { $1->add($2); $$ = $1; }
                | statement 
                     { StatementList* sl = new StatementList; sl->add($1); $$ = sl; }
                ;

statement       : assignment
                | print
                | if_else
                | while
                ;

assignment      : IDENT '=' expression
                     { $$ = new Assignment($1, $3);}
                | IDENT MULTEQUAL expression
                     { $$ = new Assignment($1, new Multiplication(new Identifier($1), $3));}
                | IDENT MINUSEQUAL expression
                     { $$ = new Assignment($1, new Subtraction(new Identifier($1), $3));}
                | IDENT PLUSEQUAL expression
                     { $$ = new Assignment($1, new Addition(new Identifier($1), $3));} 
                | IDENT MODEQUAL expression
                     { $$ = new Assignment($1, new Modulus(new Identifier($1), $3));}
                | IDENT DIVEQUAL expression
                     { $$ = new Assignment($1, new Division(new Identifier($1), $3));}
                | INC IDENT
                     { $$ = new Assignment($2, new Addition(new Identifier($2)));} 
                | IDENT DEC
                     { $$ = new Assignment($1, new Subtraction(new Identifier($1)));} 
                | IDENT POWEQUAL expression
                     { $$ = new Assignment($1, new Exponent(new Identifier($1), $3));}
                | IDENT INC
                     { $$ = new Assignment($1, new Addition(new Identifier($1)));} 
                | DEC IDENT
                     { $$ = new Assignment($2, new Subtraction(new Identifier($2)));}  
                ;

if_else         : IF expression ':' statement_list END
                     { $$ = new IfElse($2, $4); }
                | IF expression ':' END
                     { $$ = new IfElse($2, new StatementList()); }  
                | IF expression ':' statement_list ELSE ':' statement_list END
                     { $$ = new IfElse($2, $4, $7); } 
                | IF expression ':' statement_list ELSE ':' END
                     { $$ = new IfElse($2, $4, new StatementList()); }
                ;
                
print           : PRINT expression
                     { $$ = new Print($2); }
                ;


while           : WHILE expression ':' statement_list END
                     { $$ = new While($2, $4); }
                  ;

expression      : '(' expression ')'
                     { $$ = $2; }
                
                | IDENT
                     { $$ = new Identifier($1);
                       delete [] $1;
                     }
                | INTNUM
                     { $$ = new Constant($1); }
                | FLOATNUM
                     { $$ = new Constant($1); }
                | expression '+' expression
                     { $$ = new Addition($1, $3); }
                | expression '-' expression
                     { $$ = new Subtraction($1, $3); }
                | expression '/' expression
                     { $$ = new Division($1, $3); }
                | expression '*' expression
                     { $$ = new Multiplication($1, $3); }
                | expression '>' expression
                     { $$ e= new GreaterThan($1, $3); }
                | expression '<' expression
                     { $$ = new LessThan($1, $3); }
                | expression LEQUAL expression
                     { $$ = new LessThanOrEqualTo($1, $3); }
                | expression NOTEQUAL expression
                     { $$ = new NotEquals($1, $3); }
                | expression GEQUAL expression
                     { $$ = new GreaterThanOrEqualTo($1, $3); }
                ;

expression_list :
                     { $$ = new ExpressionList(); }
                | expression_list ',' expression
                     { $1->add($3);
                       printf("expression added");
                     }
                | expression
                     { ExpressionList* mylist = new ExpressionList();
                       mylist->add($1);
                       printf("expression added");
                     }
                ;
%%

