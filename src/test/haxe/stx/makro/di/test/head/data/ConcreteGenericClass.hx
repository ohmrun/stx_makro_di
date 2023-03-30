package stx.makro.di.test.head.data;

class ConcreteGenericClass extends GenericClass<String>{
  public function new(){
    super();
    this.value = "Hello";
  }
}