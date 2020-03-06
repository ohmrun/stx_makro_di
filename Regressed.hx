class Regressed{
  public function new(){

  }
  public macro function toot(self:haxe.macro.Expr):haxe.macro.Expr {
    return macro { trace("toot"); }
  }
  public static macro function tooter():haxe.macro.Expr {
    return macro { trace("tooter"); }
  }
  public function scoot(){

  }
}