# stx_makro_di
simple, powerful dependency injection


code pinched from somewhere.

```
import stx.makro.di;

var di = new DI();
    di.add(Type.new);
    di.add(TypeDependency.new);

    di.run(
      function(x:Type){ 
        //x.dependency is built;
      }
    );
```


No two types can be in the same module, but you can `extend` a module and when searching factories, the
child will defer unfound to the parent, passing in its own resolver for future lookups.

check Main.hx for more involved stuff