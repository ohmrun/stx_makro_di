package stx;

import haxe.macro.Expr;
import haxe.macro.Context;

import stx.pkg.*;

abstract Pkg(Dynamic){
  public function new(fn:Void->Void){
    var mod = Module.here();
    this = {};
  }
  static macro function hmm(e:Expr){
    trace(e);
    return e;
    
  }
}