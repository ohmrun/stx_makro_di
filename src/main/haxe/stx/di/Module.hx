package stx.di;

import tink.priority.Item;
import tink.priority.Queue;
import tink.priority.ID;

using stx.core.Lift;
using stx.log.Lift;
using stx.reflect.Lift;


@:stx.Dependencies.register(__)
class Module implements stx.di.head.data.Module{
  private final function new(){
    
  }
  public function react(di:stx.di.pack.DI){
    
  }
  public function apply(q:Queue<stx.di.head.data.Module>){
    var cls = __.of(this).reflect().definition().resolve().ident().toString();
    var id  = '$cls::apply';
    q.add({
      data : this,
      id   : id
    });
  }
}