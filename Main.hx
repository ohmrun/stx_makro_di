
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
        di.run(
          function(v:TestClass<String>){
            trace(v);
          }
        );
    var di2 = di.extend();
        di2.add(
          function(){
            var out =  new SubClass();
                out.value = "HI";
            return out;
          }
        );
        di2.run(
          function(v:SubClass){
            trace(v);
          }
        );
    var di3 = di2.extend();
        di3.add(DependentOnValueInPreviousCompileUnit.new);
        di3.add(DependentOnChildUnitFromParent.new);
        di3.run(
          function(d:DependentOnValueInPreviousCompileUnit){
            trace(d);
          }
        );
        
    var di4 = di3.extend();
      di4.run(
        function(d:WithNotFound){

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