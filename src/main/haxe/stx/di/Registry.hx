package stx.di;

@:forward(iterator,push,length,map)abstract Registry(Array<Class<stx.di.core.Module>>){
  static var instance : Array<Class<stx.di.core.Module>>;
  public function new(){
    if(instance == null){
      instance = [];
    }
    this = instance;
  }
}