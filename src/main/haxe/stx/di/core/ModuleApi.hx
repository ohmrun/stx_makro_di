package stx.di.core;

import tink.priority.Queue;

interface ModuleApi{
  public function react(di:stx.di.DI):Void;
  public function apply(q:Queue<ModuleApi>):Void;
}