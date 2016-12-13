package stx.pkg;

enum SelectorT{
  ModuleSelector(m:stx.pkg.Module);
  PackageSelector(m:stx.pkg.Package);
  GlobalSelector;
}
abstract Selector(SelectorT) from SelectorT{
  public function new(self:SelectorT){
    this = self;
  }
  @:from static public function fromPackage(p:stx.pkg.Package):Selector{
    return PackageSelector(p);
  }
  @:from static public function fromModule(p:stx.pkg.Module):Selector{
    return ModuleSelector(p);
  }
  public function toString():String{
    return switch(this){
      case ModuleSelector(m)    : m.toString();
      case PackageSelector(m)   : m.toString();
      case GlobalSelector       : "";
    }
  }
  public function parent():Selector{
    return switch(this){
      case ModuleSelector(m)    : PackageSelector(m.getPackage());
      case PackageSelector(p)   : PackageSelector(p.parent());
      case GlobalSelector       : GlobalSelector; 
    }
  }
} 