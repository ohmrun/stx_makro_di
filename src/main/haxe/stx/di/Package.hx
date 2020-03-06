package stx.di;

#if (test=="stx_di")
  import stx.di.test.*;
  import stx.di.test.ConfigureDependencies;
#end

class Package extends Pack<stx.di.Package>{
  public function new(){
    super(__.here());
  }
  #if (test=="stx_di" && (!macro))
    static public function tests(){
      return [
       // new RegressionTest(),
        new FirstTest()
      ];
    }
  #end
}
enum WootDeWoot{
  Frublub;
}