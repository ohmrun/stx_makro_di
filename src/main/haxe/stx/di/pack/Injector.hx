package stx.di.pack;

import stx.di.body.Util.*;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

class Injector{
  var di : DI;
  public function new(di){
    this.di = di;
  }
	static public macro function run(self:Expr, fn:Expr):Expr {
		function rec(t:Type) {
			return switch (t) {
				case TFun(args, ret):
					var callArgs = [];
					for (arg in args) {
						var id = get_id(arg.t);
						//print('run $id');
						var access  = macro(@:privateAccess $self.di.resolver);
            var access0 = macro(@:privateAccess $self.di);
						var expr = macro $access($v{id})($access0); // always resolving on the head. late binding the context.
						callArgs.push(expr);
					}
					macro $fn($a{callArgs});
				case TAbstract(t, _):
					rec(t.get().type);
				default:
					throw new Error('"fn should be a function"', fn.pos);
					null;
			}
		}
		return rec(Context.typeof(fn));
	}
}