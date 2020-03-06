package stx;

using stx.core.Lift;
using stx.reflect.Lift;

import stx.pkg.Package;
import stx.di.Package;

using stx.core.Lift;

#if macro
  import haxe.macro.*;
  import haxe.macro.Context;
#end

@:keep
@:allow(stx.di) abstract Dependencies(stx.di.pack.DI) to stx.di.pack.DI{
  @:isVar private static var instance(get,null)        : stx.di.pack.DI;
  static function get_instance(){
    return __.option(instance).def(
      () -> {
        instance = stx.di.pack.DI.create();
        initialize();
        return instance;
      }
    );
  }
  private static var initialized                : Bool                                        = false;
  static public function initialize(){
    if(!initialized){
      initialized   = true;
      var registry  = new stx.di.pack.Registry();
      var queue     = new tink.priority.Queue();
      for (clazz in registry){
        trace(clazz);
        var configurator  = std.Type.createEmptyInstance(clazz);
            configurator.apply(queue);
      }
      for(app in queue){
        var info = __.of(app).reflect().definition().map(
          (def) -> def.locals() 
        ).resolve();
        trace('app: $app $info');
        app.react(instance);
      }
      var overrides = std.Type.createEmptyInstance(stx.Overrides);
          overrides.react(instance);
    }
  }
  public function new(){
    this = get_instance();
  }
  #if macro
    @:noUsing static public macro function derive(e:Expr){
      return stx.di.body.Injectors.run(e);
    }
  #end
  function prj():stx.di.pack.DI{
    return this;
  }
  static public function register(cl:Class<stx.di.Module>){
    new stx.di.pack.Registry().push(cl);
  }
}
