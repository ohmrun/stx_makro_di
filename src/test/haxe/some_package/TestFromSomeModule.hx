package some_package;

import Main.TestContext;
import stx.pkg.*;

class TestFromSomeModuleModule{
  public function new(){}
  public function run(){
    var a = Module.here();
    trace(a);
    trace(a.isSubmodule());
  }
  public function act(v:Context){
    var di = new DI();
        di.add(function():String{ return "hello";});
        di.add(function():Int{ return 123;});
    v.set(Module.here(),di);
  }
  public function use(r:Release){
    var di = r.get(Module.here());
        di.run(function(str:String,int:Int){
          trace(ok);
        });
  }
}