package stx.makro.di.test;


class FirstTest extends TestCase{
  public function testLift(){
    //inject(()->("hello":String));/
    //trace(stx.Dependencies.map);
    //trace(stx.Dependencies.map.get("stx.makro.di.test.FirstTest").factories);
    // derive((str:String)->{
    //   Assert.equals('hello',str);
    //   pass();
    // });
    //trace(Dependencies.map);
  }
  function test(){
    // function(v:TestClass<String>){
    //           trace(v);
    //         }

    //       /*di2.run(
  //         function(v:ConcreteGenericClass){
  //           trace(v);
  //         }
  //       di4.injector().run(
  //         function(d:WithNotFound){

  //         }
  //di3.injector().run(
    //         function(d:DependentOnValueInPreviousCompileUnit){
    //           trace(d);
    //         }
    //       );
    //         function(v:WithNotInAssembly){
  //           trace(v.notInAssembly.ok);
  //         }
  }
  public function testMonkey(){
    //trace(new stx.makro.di.Registry());
    #if (!macro)
      Di.derive(
        (x:MonkeyType)->{
          trace(x);
        }
      );
      // Injectors.run(
      //   (str:String) -> {
      //     trace(str);
      //   }
      // );
    #end
  }
}
@:stx.makro.di.Dependencies.register(__)
class FirstTestDeepAssembly{
  function get_int():Int{
    return 3;
  }
  function get_anonymous_structure():{ a : Bool }{
    return { a : true };
  }
  function get_generic_class_implementation():GenericClass<String>{
    return new ConcreteGenericClass();
  }
}
@:stx.makro.di.Dependencies.register(__)
class SecondTestDeepAssembly{
  function get_second_generic_class_implementation():ConcreteGenericClass{
    var out =  new ConcreteGenericClass();
        out.value = "HI";
    return out;
  }
}
@:stx.makro.di.Dependencies.register(__)
class ThirdTestDeepAssembly{
  function get_whatever_this_is(a:ConcreteGenericClass,b:DependentOnChildUnitFromParent){
    return new DependentOnValueInPreviousCompileUnit(a,b);
  }
}
@:stx.makro.di.Dependencies.register(__)
class FourthTestDeepAssembly{
  function get_this_too(a:ConcreteGenericClass,b:DependentOnChildUnitFromParent){
    return new DependentOnValueInPreviousCompileUnit(a,b);
  }
  function and_this(){
    return new DependentOnChildUnitFromParent();
  }
}
@:stx.makro.di.Dependencies.register(__)
class FifthTestDeepAssembly{
  function abstract_over_typedef(){
    return new AbstractOverTypedef();
  }
}
@:stx.makro.di.Dependencies.register(__)
class SixthTestDeepAssembly{
  function not_in_assembly(notInAssembly:stx.makro.di.test.head.data.NotInModule.NotInAssembly){
    return new stx.makro.di.test.head.data.WithNotInModule.WithNotInAssembly(notInAssembly);
  }
}
class SeventhTestDeepAssembly{
  function fulfill_not_in_assembly(){
    return new stx.makro.di.test.head.data.NotInModule.NotInAssembly();
  }
}
@:stx.makro.di.Dependencies.register(__)
class FirstTestAssembly extends stx.makro.di.core.Assembly{

}
@:stx.makro.di.Dependencies.register(__)
class NotherAssembly extends stx.makro.di.core.Assembly{
  override public function react(di){
    
  }
  public function stew():String{
    return "HAAAAA";
  }
}