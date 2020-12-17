#include "expression.h"

Number Constant::eval(const Symbol &st) const {
   return num;
}

Number Identifier::eval(const Symbol& st) const {
   return st[name];
}

Negation::~Negation() {
   delete op;
}


BinaryExpression::~BinaryExpression() {
   delete op1;
   delete op2;
}

Number Multiplication::eval(const Symbol& st) const {
   return op1->eval(st) * op2->eval(st);
}

Number Addition::eval(const Symbol& st) const {
   return op1->eval(st) + op2->eval(st);
}

Number Division::eval(const Symbol& st) const {
   return op1->eval(st) / op2->eval(st);
}

Number Modulus::eval(const Symbol& st) const {
   return op1->eval(st) % op2->eval(st);
}

Number Subtraction::eval(const Symbol& st) const {
   return op1->eval(st) - op2->eval(st, ft);
}


Number Exponent::eval(const Symbol& st) const {
   return op1->eval(st) ^ op2->eval(st);
}


Number LessThanOrEqualTo::eval(const Symbol& st) const {
   return op1->eval(st) <= op2->eval(st);
}

Number GreaterThanOrEqualTo::eval(const Symbol& st) const {
   return op1->eval(st) >= op2->eval(st);
}

Number LessThan::eval(const Symbol& st) const {
   return op1->eval(st) < op2->eval(st);
}

Number GreaterThan::eval(const Symbol& st) const {
   return op1->eval(st) > op2->eval(st);
}
void ExpressionList::add(Expression* exp) {
   expList.push_back(exp);
}

Number Equals::eval(const Symbol& st) const {
   return op1->eval(st) == op2->eval(st);
}

Number NotEquals::eval(const Symbol& st) const {
   return op1->eval(st) != op2->eval(st);
}


