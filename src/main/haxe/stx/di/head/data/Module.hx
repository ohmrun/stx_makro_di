package stx.di.head.data;

import tink.priority.Queue;

interface Module{
  public function react(di:stx.di.pack.DI):Void;
  public function apply(q:Queue<Module>):Void;
}