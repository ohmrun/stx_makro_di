package stx.di;

#if test
  import stx.di.test.*;
#end

typedef Injector  = stx.di.pack.Injector;
typedef Resolvers = stx.di.pack.Resolvers;
typedef DI        = stx.di.pack.DI;

class Package extends Pack<stx.di.Package>{
  public function new(){
    super();
  }
  #if test
  static public function tests(){
    return [
      new RegressionTest(),
      //new FirstTest()
    ];
  }
  #end
}