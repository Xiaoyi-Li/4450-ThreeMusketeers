%option noyywrap

%{
#include <string>
#include <sstream>
#include "parse.tab.h"

using std::string;
using std::istringstream;

extern void yyerror(const char*);
%}

ident [_a-zA-Z][_0-9a-zA-Z]*
int   [0-9]+
float [0-9]*\.[0-9]+

%%

"#"[^\r\n]* { /* comments */    }
[ \t\n]     { /* whitespace */  }
"%"         { return yytext[0]; }
"+"         { return yytext[0]; }
"-"         { return yytext[0]; }
"*"         { return yytext[0]; }
"/"         { return yytext[0]; }
"^"         { return yytext[0]; }
","         { return yytext[0]; }
":"         { return yytext[0]; }
"("         { return yytext[0]; }
")"         { return yytext[0]; }
"="         { return yytext[0]; }
"<"         { return yytext[0]; }
">"         { return yytext[0]; }
"+="        { return PLUSEQ;    }
"-="        { return MINUSEQ;   }
"*="        { return MULTEQ;    }
"/="        { return DIVEQ;     }
"%="        { return MODEQ;     }
"^="        { return POWEQ;     }
"++"        { return INC;       }
"--"        { return DEC;       }
"=="        { return EQ;        }
"!="        { return NE;        }
"<="        { return LE;        }
">="        { return GE;        }
"while"     { return WHILE;     }
"if"        { return IF;        }
"else"      { return ELSE;      }
"print"     { return PRINT;     }
"return"    { return RETURN;    }
"end"       { return END;       }
"def"       { return DEF;       }



         
{float}  { istringstream(string(yytext)) >> yylval.floatVal;
           return FLOATNUM;
         }
         
{int}    { istringstream(string(yytext)) >> yylval.intVal;
           return INTNUM;
         }


{ident}  { yylval.ident = new char[strlen(yytext)+1];
           strcpy(yylval.ident, yytext);
           return IDENT;
         }



.        { yyerror("undefined token"); yyterminate(); }
%%
