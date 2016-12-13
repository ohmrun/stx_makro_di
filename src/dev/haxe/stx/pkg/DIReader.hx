package stx.pkg;

import haxe.macro.Expr;

class DIReader{
  /*
    only allow writing of DI context in the correct position?
  */
  var di : DI;
  public function new(di){
    this.di = di;
  }
  public macro function run(self:Expr, fn:ExprOf<Function>):Expr {
    return macro di.run(fn);
  }
}