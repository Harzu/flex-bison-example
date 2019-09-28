#include <list>
#include <string>

class Oper_t {
protected: Oper_t() {};
public: virtual ~Oper_t();
};

class Expr_t {
protected: Expr_t() {};
public: virtual ~Expr_t();
};

class Block : public Oper_t {
std::list<Block *> ops;
void append(Oper_t *op) {
  Block * b = dynamic_cast<Block *>(op);
  if (b) {
    ops.splice(ops.end(), b->ops, b->ops.begin(), b->ops.end());
    delete b;
  } else {
    ops.push_back(b);
  }
}

public:
  Block(Oper_t *op) { append(op); };
  Block(Oper_t *op1, Oper_t *op2) { append(op1); append(op2); };
  ~Block();
};

class Expr_op : public Expr_t {
  Expr_t * expr;
  public: Expr_op(Expr_t *expr) : expr(expr) {}
};

class If_op : public Oper_t {
Expr_t * cond;
Block then_ops, else_ops;
public: 
  If_op(Expr_t* cond, Oper_t* then_ops, Oper_t* else_ops)
  : cond(cond), then_ops(then_ops), else_ops(else_ops) {}
};

class While_op : public Oper_t {
Expr_t * cond;
Block ops;
public:
  While_op(Expr_t *cond, Oper_t *ops)
  : cond(cond), ops(ops) {}
};

class Exit_op : public Oper_t {};

class Binary : public Expr_t {
const char* op;
Expr_t *arg1, *arg2;
public: 
  Binary(const char* op, Expr_t *arg1, Expr_t *arg2)
  : op(op), arg1(arg1), arg2(arg2) {}
};

class Assign : public Expr_t {
std::string name;
Expr_t* value;
public: 
  Assign(const std::string &name, Expr_t *value)
  : name(name), value(value) {}
};

class Unary : public Expr_t {
const char* op;
Expr_t* arg;
public: 
  Unary(const char* op, Expr_t* arg)
  : op(op), arg(arg) {}
};

class Fun_call : public Expr_t {
std::string name;
std::list<Expr_t*> args;
public:
  Fun_call(
    const std::string &name,
    const std::list<Expr_t*> &args
  ) : name(name), args(args) {}
};

class Value : public Expr_t {
std::string text;
public: 
  Value(const std::string &text) : text(text) {}
};