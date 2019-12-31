package stx.di.test;

@:stx.di.Register
class ConfigureDependencies implements stx.di.Dependents{
	public function new(){}
	public function depends(di:DI){
		di.add(
			() -> new AbstractTest().prj()
		);
	}
}