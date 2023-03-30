package stx.makro.di;

using stx.Test;

using stx.Nano;
using stx.Test;

import stx.makro.di.test.*;
import stx.makro.di.test.ConfigureDependencies;

class Test{
  static public function main(){
      __.test().run([
        // new RegressionTest(),
        new FirstTest()
      ],[]);
  }
}