package stx.di.body;


class Util{
    #if macro
        public static function get_id(type:haxe.macro.Type):String{
            var id = Std.string(
                haxe.macro.TypeTools.toComplexType(
                    haxe.macro.Context.follow(type,true)
                )
            );
            return id;
        }
    #end

    #if macro
    static public inline function print(d:Dynamic,?pos:haxe.PosInfos){
        trace(d);
    }
    #elseif js
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        //untyped console.log(d);
    }
    #elseif php
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        var v = Std.string(d);
        //untyped __php__("log_message('debug',$v)");
    }
    #else
    static public function print(d:Dynamic,?pos:haxe.PosInfos){
        Sys.println(Std.string(d));
    }
    #end
}