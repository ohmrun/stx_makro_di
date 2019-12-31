package stx.di.pack;

class Resolvers{
  @:access(stx.di.pack) static public function resolves():String->(DI->Dynamic){
    return function(type:String):DI->Dynamic {
        return function(target:DI){
            //trace('resolve: ${target.id} $type ${target.factories}');
            var inst = target.instances.get(type);
            if (inst == null) {
                var factory = target.factories.get(type);
                if (factory == null){
                    throw "NOT FOUND";//TypedError.withData(500,'$type not found',);
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