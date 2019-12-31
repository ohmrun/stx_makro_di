package stx.di.test;

class FirstTest extends TestCase{
  function test(){
    trace("MAIN");
    var di = new DI();
        di.add(
          function():Int{
            return 3;
          }
        );
        di.add(
          function(): { a : Bool }{
            return { a : true };
          }
        );
        di.add(
          function():GenericClass<String>{
            return new ConcreteGenericClass();
          }
        );
        
        /*di.run(
          function(v:TestClass<String>){
            trace(v);
          }
        );*/
    var di2 = di.extend();
        di2.add(
          function():ConcreteGenericClass{
            var out =  new ConcreteGenericClass();
                out.value = "HI";
            return out;
          }
        );
    trace("0___________________");
        /*di2.run(
          function(v:ConcreteGenericClass){
            trace(v);
          }
        );*/
    trace("1___________________");
    var di3 = di2.extend();
        di3.add(DependentOnValueInPreviousCompileUnit.new);
        di3.add(DependentOnChildUnitFromParent.new);
        di3.injector().run(
          function(d:DependentOnValueInPreviousCompileUnit){
            trace(d);
          }
        );
        
    trace("2___________________");    
    var di4 = di3.extend();
      try{
        di4.injector().run(
          function(d:WithNotFound){

          }
        );
      }catch(e:Dynamic){

      }
      trace("___________________");
    var di5 = di4.extend();
      di5.add(AbstractOverTypedef.new);
    trace("________________________________________");
    var di6 = new DI();
        di6.add(
          WithNotInModule.new
        );

    var di7 = di6.extend();
        di7.add(
          NotInModule.new
        );
        di7.injector().run(
          function(v:WithNotInModule){
            trace(v.notInModule.ok);
          }
        );
  }
}