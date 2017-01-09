package stx;

import stx.di.Fault;
import haxe.ds.StringMap;
import stx.di.Resolver;
import stx.di.Resolvers;
import haxe.macro.Expr;
import haxe.Constraints.Function;

#if macro
    import tink.macro.Types.types;
    import haxe.macro.Context;
    using haxe.macro.Tools;
    using tink.MacroApi;
#end
    import haxe.macro.Expr;
    import haxe.macro.Type;

@:allow(stx.di.Resolvers) class DI {
    public var id(default,null)          : Float;

    var instances   : std.haxe.ds.StringMap<Dynamic>;
    var factories   : std.haxe.ds.StringMap<DI->Dynamic>;

    static function copyMap<T>(map:StringMap<T>):StringMap<T>{
        var next = new StringMap();
        for(key in map.keys()){
            //DI.print('copying: $key');
            next.set(key,map.get(key));
        }
        return next;
    }
    public function copier(?factories,?instances,?id){
            instances       = instances == null ? this.instances : instances;
            factories       = factories == null ? this.factories : factories;
            id              = id == null ? this.id : id;
            var next        = new DI(copyMap(factories),copyMap(instances));
        return next;
    }
    public function new(?factories:StringMap<DI->Dynamic>,?instances:StringMap<Dynamic>,?id) {
        //DI.print('new: ${this.id} $factories, $instances');
        this.id = id == null ? Math.random() : id;

        this.instances = instances == null ? new StringMap() : instances;
        this.factories = factories == null ? new StringMap() : factories;
    }
#if macro

    static function get_id(type:Type):String{
        var id = type.reduce(true).toComplex({ direct : false }).toString();
        return id;
    }
#end
    public macro function add(self:Expr, factory:ExprOf<Function>,?force:Bool=false):Expr {
        switch (Context.typeof(factory)) {
            case TFun(args, ret):
                var id          = get_id(ret);
                DI.print('add $id');
                var callArgs    = [];
                for (arg in args) {
                    var id      = get_id(arg.t);
                    var expr    = macro (@:privateAccess $self.resolver)($v{id});
                    callArgs.push(expr);
                }
                var fn          = macro function(di){
                    return $a{callArgs}.map(
                        function(f){
                            return f(di) ;
                        }
                    );
                }
                var access  = macro (@:privateAccess $self._add);
                var out =  macro $access($v{id} ,
                    function(di){
                        var values = $fn(di);
                        stx.DI.print('_run $id');
                        return Reflect.callMethod(null,$factory,values);
                    },$v{force}
                );
                //DI.print( new haxe.macro.Printer().printExpr(out));
                return out;
            default:
                throw new Error("Factory should be a function", factory.pos);
        }
    }
    private var resolver(default,null) : Resolver = Resolvers.resolves();
    /*
    )
    public function withResolver(resolver):DI{
        return copy(null,null,null,resolver);
    }*/
    /*
    public macro function build(self:Expr,expr:ExprOf<Type>):Expr{
        var type    = Context.typeof(expr);
        //DI.print(type);
        var ctype   = get_id(type);
        //DI.print(ctype);
        return macro (@:privateAccess $self.resolver)($self,$v{ctype});
    }*/
    public macro function run(self:Expr, fn:ExprOf<Function>):Expr {
        switch (Context.typeof(fn)) {
            case TFun(args, ret):
                var callArgs = [];
                for (arg in args) {
                    var id      = get_id(arg.t);
                    DI.print('run $id');
                    var access  = macro (@:privateAccess $self.resolver);
                    var expr    = macro $access($v{id})($self);//always resolving on the head. late binding the context.
                    callArgs.push(expr);
                }
                return macro $fn($a{callArgs});
            default:
                throw new Error("fn should be a function", fn.pos);
        }
    }
    @:noCompletion inline function _has(id:String):Bool{
      return factories.exists(id);
    }
    @:noCompletion inline function _add(id:String, factory:DI->Dynamic,?force:Bool=false):Void {
        DI.print('_add $id');
        if (factories.exists(id) && !force)
            throw 'Duplicate factory declaration for $id';
        factories.set(id,factory);
    }
    public function extend():DI{
        var next = copier();
        //DI.print('extend: FROM ${this.factories} TO ${next.factories}');
        return next;
    }
    #if macro
    static public function print(d:Dynamic,?pos:haxe.PosInfos){

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
        //Sys.println(Std.string(d));
    }
    #end
}
