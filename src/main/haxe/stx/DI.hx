package stx;

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
    var factories   : std.haxe.ds.StringMap<Void->Dynamic>;
    var parent      : DI;
    var resolver    : String->Dynamic;

    public function copy(?instances,?factories,?parent,?resolver){
        var next            = new DI(parent == null ? this.parent : parent, resolver == null ? this.resolver : resolver);
            next.instances  = instances == null ? this.instances : instances;
            next.factories  = factories == null ? this.factories : factories;
        return next;
    }
    public function new(?parent:DI,?resolver:String->Dynamic) {
        this.id = Math.random();
        if(resolver == null){
            resolver = Resolvers.resolve.bind(this);
        }
        this.resolver  = resolver; 
        this.parent    = parent;
        this.instances = new std.haxe.ds.StringMap();
        this.factories = new std.haxe.ds.StringMap();
    }
#if macro
    
    static function get_id(type:Type):String{
        var id = type.reduce(true).toComplex({ direct : false }).toString();
        return id;
    }
#end
    public macro function add(self:Expr, factory:ExprOf<Function>):Expr {
        switch (Context.typeof(factory)) {
            case TFun(args, ret):
                var id          = get_id(ret);
                var callArgs    = [];
                for (arg in args) {
                    var id = get_id(arg.t);
                    callArgs.push(macro (@:privateAccess $self.resolver)($v{id}));
                }
                var out =  macro (@:privateAccess $self._add)($v{id} , function() return ($factory)($a{callArgs}));
                //trace( new haxe.macro.Printer().printExpr(out));
                return out; 
            default:
                throw new Error("Factory should be a function", factory.pos);
        }
    }
    public function withResolver(resolver):DI{
        return copy(null,null,null,resolver); 
    }
    public macro function run(self:Expr, fn:ExprOf<Function>):Expr {
        switch (Context.typeof(fn)) {
            case TFun(args, ret):
                var callArgs = [];
                for (arg in args) {
                    var id = get_id(arg.t);
                    callArgs.push(macro (@:privateAccess $self.resolver)($v{id}));
                }
                return macro $fn($a{callArgs});
            default:
                throw new Error("fn should be a function", fn.pos);
        }
    }
    @:noCompletion inline function _has(id:String):Bool{
      return factories.exists(id);
    }
    @:noCompletion inline function _add(id:String, factory:Void->Dynamic):Void {
        if (factories.exists(id))
            throw 'Duplicate factory declaration for $id';
        factories.set(id,factory);
    }
    public function extend():DI{
        return new DI(this);
    }
}