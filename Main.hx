//import stx.di.Package;


using Lambda;

class Main{
  static function main(){
    regress();
    regress0();
    
    #if test
      var runner = new haxe.unit.TestRunner();
      stx.di.Package.tests().iter(
        (x) -> runner.add(x)
      );
      runner.run();
    #end
  }
  static function regress(){
    var regression = new Regressed();
    regression.scoot();
    regression.toot();
    
    Regressed.tooter();
  }
  static function regress0(){
    var regression = new stx.Regression();
        regression.scoot();
        regression.toot();
  }
}