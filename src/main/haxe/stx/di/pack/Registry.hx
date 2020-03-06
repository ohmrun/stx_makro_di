package stx.di.pack;

@:forward(iterator,push)abstract Registry(stx.alias.StdArray<Class<stx.di.Module>>){
  static var instance : stx.alias.StdArray<Class<stx.di.Module>>;
  public function new(){
    if(instance == null){
      instance = [];
    }
    this = instance;
  }
}