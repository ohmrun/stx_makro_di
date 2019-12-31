package stx.di.test.head.data;

class WithNotInModule{
  public function new(notInModule){
    this.notInModule = notInModule;
  }
  public var notInModule : NotInModule;
}