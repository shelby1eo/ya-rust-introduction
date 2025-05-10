# Scalar

Not much to say here, variables on the stack are not effected.
For scalar there the move semantics is not really applicable since the memory get copied and the Copy trait is implemented.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let a = 5;
    println!("{a}");
    let mut b = a;
    b = 1;
    println!("{b}");
    println!("{a}");
}
```

```rust,editable
fn main() {
    let a = 5;
    println!("{a}");
    let mut b = a;
    b = 1;
    println!("{b}");
    println!("{a}");
}
```


