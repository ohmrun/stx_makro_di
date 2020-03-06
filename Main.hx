//import stx.di.Package;


using Lambda;

class Main{
  static function main(){
    #if regression
      //regress();
      //regress0();
    #end
    
    #if test
      utest.UTest.run(
        cast stx.di.Package.tests()
      );
    #end
  }
  // static function regress(){
  //   var regression = new Regressed();
  //   regression.scoot();
  //   regression.toot();
    
  //   Regressed.tooter();
  // }
  // static function regress0(){
  //   var regression = new stx.Regression();
  //       regression.scoot();
  //       regression.toot();
  // }
}