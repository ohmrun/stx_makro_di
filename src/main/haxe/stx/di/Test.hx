package stx.di;

using stx.Test;

#if (test=="stx_di")
  import stx.di.test.*;
  import stx.di.test.ConfigureDependencies;
#end

class Test{
  #if (test=="stx_di")
    static public function main(){
        // __.test([
        //   // new RegressionTest(),
        //   //new FirstTest()
        // ],[]);
    }
  #end
}