package stx.pkg;

using thx.Arrays;
using thx.Strings;

#if macro
  using tink.MacroApi;
#end
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

abstract Package(String){
  @:allow(stx.pkg) function new(id:String){
    this = id;
  }  
  public function toString(){
    return this;
  }
  public function parent(){
    return new Package(this.split(".").dropRight(1).join("."));
  }
  public function isEmpty(){
    return this == "" || this == null;
  }
}