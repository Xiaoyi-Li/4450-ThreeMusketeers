#ifndef STATEMENT_H
#define STATEMENT_H

#include <string>
#include <list>

using std::string;
using std::list;

extern int yylineno;

class SymbolTable;
class FunctionTable;
class Function;
class Expression;
class ExpressionList;

class Statement {
public:
   void eval(SymbolTable&);
   int  getLineNumber() const;
   int lineNumber;
   Statement()      : lineNumber(yylineno-1) { }
};



class StatementList {
public:
   void eval(SymbolTable&) const;
   void add(Statement*);
   list<Statement*> stmtList;
};

class Assignment: public Statement {
public:
   Assignment(const string& n, Expression *e) : name(n), exp(e) { }
   void eval(SymbolTable&) const;
   string      name;
   Expression* exp;
};



class Print : public Statement {
public:
   Print(Expression* e) : exp(e) { }
   void eval(SymbolTable) const;
   Expression* exp;
};

class IfElse : public Statement {
public:
   IfElse(Expression *cond, StatementList* tList, StatementList* fList) : condition(cond), trueList(tList), falseList(fList) { }
   IfElse(Expression *cond, StatementList* tList) : condition(cond), trueList(tList), falseList(new StatementList()) { }

   void eval(SymbolTable&) const;
   Expression*    condition;
   StatementList* trueList;
   StatementList* falseList;
};


class While : public Statement {
public:
   While(Expression* cond, StatementList* sList) : condition(cond), stmtList(sList) { }
   void eval(SymbolTable) const;
   Expression*    condition;
   StatementList* stmtList;
};




#endif
