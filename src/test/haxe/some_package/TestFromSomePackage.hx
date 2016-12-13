package some_package;


import stx.Pkg;
import stx.pkg.DI;
import stx.pkg.Package;
import stx.pkg.Module;
import stx.pkg.Map;

class TestFromSomePackage{
  public function new(){
    new Pkg(
      function(){}
    );
  }
  public function run(){
    var a = Module.here();
    trace(a);
    trace(a.isSubmodule());
    trace(a.getPackage());
  }
  public function act(v:Map){
    /*
    var di = new DI();
        di.add(function():String{ return "hello";});
        di.add(function():Int{ return 123;});
    v.set(Module.here(),di);*/
  }
}