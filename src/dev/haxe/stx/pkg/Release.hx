package stx.pkg;

import haxe.ds.StringMap;

@:allow(stx.pkg.Context,stx.pkg) abstract Release(StringMap<DI>){
  function new(self){
    this = self;
  }
  public function get(sel:Selector):DIReader{
    var location  = sel.toString();
    var out       = this.get(location);
    var reader    = out != null ? out.reader() : null; 
    return reader;
  }
}