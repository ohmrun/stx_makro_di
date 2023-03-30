package stx.makro.di.test;

import haxe.macro.Expr;

@:stx.makro.di.Dependencies.
class Regression{
  public function new(){

  }
  macro public function toot(self:Expr):Expr {
    return macro { trace("toot"); }
  }
  public function scoot(){

  }
}