#include <iostream>
#include <cstdio>

using std::cerr;
using std::endl;

extern int yyparse();
extern int parseResult;
extern FILE* yyin;

int main(int argc, char** argv) {
   
   if (argc > 1) {
      yyin = fopen(argv[1], "r+");

      if (yyin == NULL) {
         printf("Could not open file.\n");
         return 0;
      }
   }
   else
   {
         printf("file required.\n");
   }

   yyparse();

   return 0;
}
