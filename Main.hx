import stx.di.Fault;
import stx.DI;


typedef Numpty = String;

class TestClass<T>{
  public var value : T;
  public function new(){
  }
}
class SubClass extends TestClass<String>{
  public function new(){
    super();
    this.value = "Hello";
  }
}
class DependentOnChildUnitFromParent{
  public function new(){
    
  }
}
class DependentOnValueInPreviousCompileUnit{
  var sub   : SubClass;
  var other : DependentOnChildUnitFromParent;
  public function new(sub:SubClass,other){
    this.other = other;
    this.sub = sub;
  }
}
class TestWithNotInModule{
  public function new(notInModule){
    this.notInModule = notInModule;
  }
  public var notInModule : NotInModule;
}
class NotInModule{
  public function new(){
    ok = true;
  }
  public var ok  : Bool;
}
class Main{
  static function main(){
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
          function():TestClass<String>{
            return new SubClass();
          }
        );
        
        /*di.run(
          function(v:TestClass<String>){
            trace(v);
          }
        );*/
    var di2 = di.extend();
        di2.add(
          function():SubClass{
            var out =  new SubClass();
                out.value = "HI";
            return out;
          }
        );
    trace("0___________________");
        /*di2.run(
          function(v:SubClass){
            trace(v);
          }
        );*/
    trace("1___________________");
    var di3 = di2.extend();
        di3.add(DependentOnValueInPreviousCompileUnit.new);
        di3.add(DependentOnChildUnitFromParent.new);
        di3.run(
          function(d:DependentOnValueInPreviousCompileUnit){
            trace(d);
          }
        );
        
    trace("2___________________");    
    var di4 = di3.extend();
      try{
        di4.run(
          function(d:WithNotFound){

          }
        );
      }catch(e:Fault){

      }
      trace("___________________");
    var di5 = di4.extend();
      di5.add(AbstractOverTypedef.new);
    trace("________________________________________");
    var di6 = new DI();
        di6.add(
          TestWithNotInModule.new
        );

    var di7 = di6.extend();
        di7.add(
          NotInModule.new
        );
        di7.run(
          function(v:TestWithNotInModule){
            trace(v.notInModule.ok);
          }
        );

  }
  
}
class NotFound{
  public function new(){}
}
class WithNotFound extends DependentOnValueInPreviousCompileUnit{
  public function new(sub:SubClass,other,notfound:NotFound){
    super(sub,other);
  }
}
typedef Typedef = String;
@:forward abstract AbstractOverTypedef(Typedef) from Typedef to Typedef{
  public function new(){
    this = "";
  }
}