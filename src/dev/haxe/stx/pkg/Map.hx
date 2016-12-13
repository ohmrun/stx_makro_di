package stx.pkg;

using Lambda;
import haxe.macro.Expr;

import haxe.PosInfos;
import haxe.ds.StringMap;

@:allow(stx.pkg.Map) abstract Map(StringMap<DI>){
  @:isVar static public var instance(get,null): Map;
  static function get_instance(){
    return instance == null ? new Map() : instance;
  }
  @:isVar static public var locked(default,null):Bool = false;
  static public function lock(?pos:haxe.PosInfos){
    locker = pos;
    locked = true;
  }
  static public var locker : haxe.PosInfos;
  
  function new(){
    this = new StringMap();
  }
  public function keys():Array<String>{
    return { iterator : this.keys }.array();
  }
  public function set(sel:Selector,di:DI){
    if(locked){
      throw 'Map Locked: $locker';
      return;
    }
    var location = sel.toString();
    this.set(location,di);
  }
  public function release(?pos:haxe.PosInfos):Release{
    lock(pos);
    return new Release(this);
  }
}