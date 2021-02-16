package stx.di;


#if (test=="stx_di")
  import stx.di.test.*;
  import stx.di.test.ConfigureDependencies;
#end

class Test{
  #if (test=="stx_di" && (!macro))
    static public function main(){
        stx.Test.test([
          // new RegressionTest(),
          new FirstTest()
        ],[]);
    }
  #end
}