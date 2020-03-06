package stx.di;

import haxe.PosInfos;
import stx.di.pack.*;
import stx.di.body.Injectors;

class Lift{
  static public macro function test(expr:haxe.macro.Expr.ExprOf<String>){
    return macro {};
  }
  //static public function inject(_:Wildcard,?pos:PosInfos){
    //var root = Dependencies.instance;
  //}
  
}