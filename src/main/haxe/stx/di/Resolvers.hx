package stx.di;

class Resolvers{
  static public function resolve(target:DI,type:String):Dynamic {
        //trace('resolve: ${target.id} $type');
        var inst = target.instances.get(type);
        if (inst == null) {
            var factory = target.factories.get(type);
            if (factory == null){
                if(target.parent!=null){
                    inst = resolve(target.parent,type);
                }else {
                    throw 'No factory defined for type $type';
                }
            }else{
                target.instances.set(type,factory());
                inst = target.instances.get(type);
            }
        }
        return inst;
  }
}