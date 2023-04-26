package stx.makro.di.test.head.data;

class WithNotInAssembly{
  public function new(notInAssembly){
    this.notInAssembly = notInAssembly;
  }
  public var notInAssembly : stx.makro.di.test.head.data.some_package.NotInAssembly;
}