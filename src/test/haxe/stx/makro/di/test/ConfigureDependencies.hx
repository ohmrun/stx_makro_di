package stx.makro.di.test;

@:stx.makro.di.Dependencies.register(__)
class ConfigureDependencies extends stx.makro.di.core.Assembly{
	
	public function main():Int{
		return 0;
	}
	public function test(i:Int):MonkeyType{
		return MonkeyMonkey;
	}
}