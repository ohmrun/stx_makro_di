package stx.pkg;

using thx.Arrays;
using thx.Strings;

#if macro
  using tink.MacroApi;
#end
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

abstract Module(String){
  function new(id:String){
    this = id;
  }
  static public macro function here():ExprOf<stx.pkg.Module>{
    var type    = Context.getLocalType();
    var id      = type.toComplex().toString();
    return macro @:privateAccess new Module('$id');
  }  
  public inline function isSubmodule():Bool{
    var all = this.split(".");
    return all[all.length - 2].substr(0,1).isUpperCase();
  }
  public inline function getHead():Module{
    return isSubmodule() ?  new Module(this.split(".").dropRight(1).join(".")) : new Module(this);
  } 
  public inline function getPackage():Package{
    return isSubmodule() ? getHead().getPackage() : new Package(this.split(".").dropRight(1).join("."));
  }
  public function toString():String{
    return this;
  }
}