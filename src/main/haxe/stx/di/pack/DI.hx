package stx.di.pack;

import stx.di.body.Util;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

import haxe.ds.StringMap;

import stx.di.pack.Injector;
import stx.di.pack.Resolvers;
import stx.di.head.data.Resolver;

@:allow(stx.di.pack.Resolvers) class DI{
  public macro function tootksy(self:Expr):Expr {
    return macro { trace("tootksy"); }
  }
  macro public function add(self:Expr, factory:Expr, ?force:Bool = false):Expr {
    function rec(t:Type){
        return switch(t){
          case TFun(args, ret):
            var id = Util.get_id(ret);
            // print('add $id');
            var callArgs = [];
            for (arg in args) {
              var id    = Util.get_id(arg.t);
              var expr  = macro(@:privateAccess $self.resolver)($v{id});
              callArgs.push(expr);
            }
            var fn = macro function(di:DI) {
              return $a{callArgs}.map(function(f) {
                  return f(di);
                });
            }
            var access = macro(@:privateAccess $self._add);
            var out = macro $access($v{id}, function(di) {
              var values = $fn(di);
              // stx.di.Util.print('_run $id');
              return Reflect.callMethod(null, $factory, values);
            }, $v{force});
            // DI.print( new haxe.macro.Printer().printExpr(out));
            out;
          case TAbstract(t,_):
            rec(t.get().type);
          default:
            throw new Error("Factory should be a function", factory.pos);
        }
      }
      return rec(Context.typeof(factory));
    }
	@:noCompletion inline function _has(id:String):Bool {
		return factories.exists(id);
	}

	@:noCompletion inline function _add(id:String, factory:DI->Dynamic, ?force:Bool = false):Void {
		// print('_add $id');
		if (factories.exists(id) && !force)
			throw 'Duplicate factory declaration for $id';
		factories.set(id, factory);
	}

	public function extend():DI {
		var next = copy(null, new StringMap(), Math.random());
		// next.copy(this.factories,this.instances);
		// trace('extend: FROM ${this.factories} TO ${next.factories}');
		return next;
	}
	public function concat(that:DI):DI{
		var factories = new StringMap();
		for(key=>val in this.factories){
			factories.set(key,val);
		}
		for(key=>val in that.factories){
			factories.set(key,val);
		}
		return copy(null,factories,Math.random());		
	}
  public function injector(){
    return new Injector(this);
  }
  public var id(default,null)          : Float;




  var instances               : std.haxe.ds.StringMap<Dynamic>;
  var factories               : std.haxe.ds.StringMap<DI->Dynamic>;
  var resolver(default,null)  : Resolver = Resolvers.resolves();

  static function copyMap<T>(map:StringMap<T>):StringMap<T>{
    var next = new StringMap();
    for(key in map.keys()){
      //DI.print('copying: $key');
      next.set(key,map.get(key));
    }
    return next;
  }
  function copy(?factories,?instances,?id){
    instances       = instances == null ? this.instances : instances;
    factories       = factories == null ? this.factories : factories;
    id              = id == null ? this.id : id;
    var next        = new DI(copyMap(factories),copyMap(instances));
    return next;
  }
  public function new(?factories:StringMap<DI->Dynamic>,?instances:StringMap<Dynamic>,?id) {
    //DI.print('new: ${this.id} $factories, $instances');
    this.id = id == null ? Math.random() : id;

    this.instances = instances == null ? new StringMap() : instances;
    this.factories = factories == null ? new StringMap() : factories;
  }
}
