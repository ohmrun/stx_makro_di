//import stx.di.Package;

import stx.Dependencies;

using Lambda;

class Main{
  static function main(){
    trace("main");
    #if regression
      //regress();
      //regress0();
    #end
    
    #if test
      stx.di.Test.main();
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