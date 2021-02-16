package stx.di;

import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Printer;
import haxe.macro.MacroStringTools;

using tink.CoreApi;
using tink.MacroApi;

import stx.makro.alias.StdExpr;

using stx.Pico;
using stx.Nano;
using stx.Ds;
using stx.Makro;
using stx.makro.Type;

import tink.priority.ID;
import tink.MacroApi.ClassBuilder;
import tink.SyntaxHub;

class Plugin{
  @:access(tink.priority.ID) static public function use(){
    trace('use: stx.Di');
    stx.Dependencies;
    var here = __.here();
    SyntaxHub.classLevel.add(
      {
        data  : apply,  
        id    : __.option(here).map(Std.string).defv(null)
      }
    );
    tink.SyntaxHub.transformMain.add(
      {
        data : (expr:Expr) -> {
          return {
            pos  : __.here(),
            expr : EBlock([macro @:privateAccess stx.Dependencies.instance,expr]) 
          };
        }
      }
    );
  }
  static function apply(cb:ClassBuilder):Bool{
    var printer   = new Printer();
    var target    = cb.target;

    var should = target.makro().interfaces(true).any(
      (ref) -> {
        var a = stx.makro.type.BaseType._.getModule(ref.t.get());
        var b = stx.makro.core.Module.fromIdentDef(Identifier.lift("stx.di.core.ModuleApi").toIdentDef());
        var c = a.equals(cast b);
        return c;
      }
    );

    if(!should){
      return should;
    }
       should  = should && !(stx.makro.type.BaseType._.getModule(target).equals({pack:"stx.di.core".split('.'),name:"Module"}));
    if(should){   
      //trace('should: $target');
      var arr = [];
      for( next in cb ){
        switch(
          [
            ["react","apply"].any((x) -> next.name == x),
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
          var expr  = macro stx.di.Injectors.add(
            $i{"di"},
            $i{member.name}
          );
          return expr;
        }
      ).toBlock();

      switch(cb.memberByName("react")){
        case Success(v) : cb.removeMember(v);
        default         : 
      };

      var func : Function = {
        args : [{name : "di",type : MacroStringTools.toComplex("stx.di.DI")}],
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
      var btype           = cb.target.makro().toBaseType(); 
      var id              = 
        MacroStringTools.toFieldExpr(
          new stx.makro.core.Module({ name : btype.name, pack : btype.pack, module : __.option(new haxe.io.Path(btype.module)) }).toString().split(".")
        ); 
      var init_func : Function = {
        args : [],
        ret  : null,
        expr : macro {
          trace($e{id});
          new stx.di.Registry().push($e{id});
        }
      }
      var init : Member = {
        name    : "__init__",
        kind    : FFun(init_func),
        pos     : __.here(),
        access  : [AStatic]
      }
      cb.addMember(init);
      trace('build: ${cb.target.pack.join(".")}.${cb.target.name}');
      //trace(cb.target);
      //trace(@:privateAccess cb.memberList);
    }
    return should;
  }
}