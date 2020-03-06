package stx.di.pack;

class Resolvers{
  @:access(stx.di.pack) static public function resolves():String->(DI->Dynamic){
    return function(type:String):DI->Dynamic {
        //trace(type);
        return function(target:DI){
            //trace('resolve: ${target.id} $type ${target.factories}');
            var inst = target.instances.get(type);
            // trace(target.factories);
            // trace(inst);
            if (inst == null) {
                var factory = target.factories.get(type);
                // trace(factory);
                if (factory == null){
                    throw '"$type" not found: (${target.factories})';
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