package stx.di;

import stx.di.Package;


@:forward abstract Dependencies(Injector) to Injector{
  private static var instance : DI = new DI();

  public function new(){
    this = instance.injector();
    trace(this.globals());
  }
}
