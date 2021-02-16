package stx.di.test;


class FirstTest extends utest.Test{
  public function testLift(){
    //inject(()->("hello":String));/
    //trace(stx.Dependencies.map);
    //trace(stx.Dependencies.map.get("stx.di.test.FirstTest").factories);
    // derive((str:String)->{
    //   Assert.equals('hello',str);
    //   pass();
    // });
    //trace(Dependencies.map);
  }
  // function test(){
  //   trace("MAIN");
  //   var di = __.di();
  //       Lift.add(di,
  //         function():Int{
  //           return 3;
  //         }
  //       );
  //       di.add(
  //         function(): { a : Bool }{
  //           return { a : true };
  //         }
  //       );
  //       di.add(
  //         function():GenericClass<String>{
  //           return new ConcreteGenericClass();
  //         }
  //       );
        
  //       /*di.run(
  //         function(v:TestClass<String>){
  //           trace(v);
  //         }
  //       );*/
  //   var di2 = di.extend();
  //       di2.add(
  //         function():ConcreteGenericClass{
  //           var out =  new ConcreteGenericClass();
  //               out.value = "HI";
  //           return out;
  //         }
  //       );
  //   trace("0___________________");
  //       /*di2.run(
  //         function(v:ConcreteGenericClass){
  //           trace(v);
  //         }
  //       );*/
  //   trace("1___________________");
  //   var di3 = di2.extend();
  //       di3.add((a:ConcreteGenericClass,b:DependentOnChildUnitFromParent) -> new DependentOnValueInPreviousCompileUnit(a,b));
  //       di3.add(() -> new DependentOnChildUnitFromParent());
  //       di3.injector().run(
  //         function(d:DependentOnValueInPreviousCompileUnit){
  //           trace(d);
  //         }
  //       );
        
  //   trace("2___________________");    
  //   var di4 = di3.extend();
  //     try{
  //       di4.injector().run(
  //         function(d:WithNotFound){

  //         }
  //       );
  //     }catch(e:Dynamic){

  //     }
  //     trace("___________________");
  //   var di5 = di4.extend();
  //     di5.add(() -> new AbstractOverTypedef());
  //   trace("________________________________________");
  //   var di6 = __.di();
  //       di6.add(
  //         (notInModule:stx.di.test.head.data.NotInModule) -> new WithNotInModule(notInModule)
  //       );

  //   var di7 = di6.extend();
  //       di7.add(
  //         () -> new NotInModule()
  //       );
  //       di7.injector().run(
  //         function(v:WithNotInModule){
  //           trace(v.notInModule.ok);
  //         }
  //       );
  // }
  public function testMonkey(){
    //trace(new stx.di.Registry());
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

@:stx.Dependencies.register(__)
class FirstTestModule extends stx.di.core.Module{

}
@:stx.Dependencies.register(__)
class NotherModule extends stx.di.core.Module{
  override public function react(di){
    
  }
  public function stew():String{
    return "HAAAAA";
  }
}