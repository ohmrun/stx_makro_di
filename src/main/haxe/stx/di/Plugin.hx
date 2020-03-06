package stx.di;

import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Printer;
import haxe.macro.MacroStringTools;

using tink.CoreApi;
using tink.MacroApi;

import stx.makro.alias.StdExpr;

import stx.core.Package;
import stx.ds.Package;

using stx.ds.Lift;
using stx.core.Lift;
using stx.reflect.Lift;
using stx.makro.Lift;

import tink.priority.ID;
import tink.MacroApi.ClassBuilder;
import tink.SyntaxHub;

class Plugin{
  @:access(tink.priority.ID) static public function use(){
    var here = stx.core.Lift.here(__);
    SyntaxHub.classLevel.add(
      {
        data  : apply,  
        id    : __.option(here).map(Std.string).defv(null)
      }
    );
  }
  static function apply(cb:ClassBuilder):Bool{
    var printer   = new Printer();
    var target    = cb.target;
    return false;
    var should = target.makro().interfaces(true).any(
      (ref) -> {
        var a = stx.makro.type.body.BaseTypes.getModule(ref.t.get());
        var b : Module = {
          pack : "stx.di.head.data".split("."),
          name : "Module"
        }
        var c = a.equals(cast b);
        return c;
      }
    );
    if(!should){
      return should;
    }
       should  = should && !(stx.makro.type.body.BaseTypes.getModule(target).equals({pack:"stx.di".split('.'),name:"Module"}));
    if(should){   
      var arr = [];
      for( next in cb ){
        switch(
          [
            ["react","apply"].ds().any((x) -> next.name == x),
            new EnumValue(next.kind).alike(FFun(null))
          ]
        ){
          case [false,true] : arr.push(next);
          default : 
        }
      }
      var exprs : StdExpr = arr.map(
        (member) -> {
          var pos   = Context.currentPos();
          var expr = macro stx.di.body.Injectors.add(
            $i{"di"},
            $i{member.name}
          );
          return expr;
        }
      ).toBlock();

      switch(cb.memberByName("react")){
        case Success(v) : cb.removeMember(v);
        default : 
      };

      var func : Function = {
        args : [{name : "di",type : MacroStringTools.toComplex("stx.di.pack.DI")}],
        ret  : null,
        expr : exprs
      }
      var member : Member = {
        name    : "react",
        kind    : FFun(func),
        pos     : Context.currentPos()
      };
      member.overrides  = true;
      member.isPublic   = true;

      cb.addMember(member);
      trace('build: ${cb.target.pack.join(".")}.${cb.target.name}');
    }
    return should;
  }
}