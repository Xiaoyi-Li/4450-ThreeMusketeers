#include <iostream>
#include <cstdlib>
#include "expression.h"
#include "statement.h"

using std::cout;
using std::cerr;
using std::endl;

int Statement::getLineNumber() const {
   return lineNumber;
}

void Assignment::eval(SymbolTable& st) const {
   st[name] = exp->eval(st);
}



void While::eval(SymbolTable& st, FunctionTable& ft) const {
   while (condition->eval(st) > 0) {
      stmtList->eval(st);
   }
}

void IfElse::eval(SymbolTable& st) const {
   if (condition->eval(st) > 0) {
      trueList->eval(st);
   } else {
      falseList->eval(st);
   }
}

StatementList::~StatementList() {
   for (list<Statement*>::const_iterator it = stmtList.begin(); it != stmtList.end(); ++it) {
      delete *it;
   }
}

void StatementList::add(Statement* stmt) {
   stmtList.push_back(stmt);
}
