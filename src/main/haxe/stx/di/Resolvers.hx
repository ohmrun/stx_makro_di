package stx.di;

class Resolvers{
  static public function resolve(target:DI,type:String,?resolver:Resolver):Dynamic {
    if(resolver == null){
        resolver = target.resolver;
    }
    //trace('resolve: ${target.id} $type');
    var inst = target.instances.get(type);
    if (inst == null) {
        var factory = target.factories.get(type);
        if (factory == null){
            if(target.parent!=null){
                inst = resolver(target.parent,type,resolver);
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