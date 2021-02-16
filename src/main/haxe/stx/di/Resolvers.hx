package stx.di;

class Resolvers{
  @:access(stx.di) static public function resolves():String->(DI->Dynamic){
    return function(type:String):DI->Dynamic {
        //throw(type);
        return function(target:DI){
            //trace('resolve: ${target.id} $type ${target.factories}');
            var inst = target.instances.get(type);
            // trace(target.factories);
            //trace(type);
            if (inst == null) {
                var factory = target.factories.get(type);
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