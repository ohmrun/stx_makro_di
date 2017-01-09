package stx.di;

import stx.di.Fault;
using stx.Pointwise;
import stx.core.Y;

using tink.CoreApi;

import haxe.ds.Option;

class Resolvers{
  static public function resolves():String->(DI->Dynamic){
    return function(type:String):DI->Dynamic {
        return function(target:DI){
            //trace('resolve: ${target.id} $type ${target.factories}');
            var inst = target.instances.get(type);
            if (inst == null) {
                var factory = target.factories.get(type);
                if (factory == null){
                    throw NotFound(type);
                }else{
                    target.instances.set(type,factory(target));
                    inst = target.instances.get(type);
                }
            }
            return inst;
        }
    }
  }
}