package stx.di;

import stx.DI;

@:forward abstract Dependencies(DI){
  private static var instance : DI;

  public function new(){
    if(instance == null){
      instance = new DI();
    }
    this = instance;
  }
}
