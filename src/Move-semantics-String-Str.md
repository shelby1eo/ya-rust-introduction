# String

Since string is a wrapper over Vec the same behaviour happens here.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main(){
    let a = String::from("something");
    let b = a;
    println!("{}", b);
}
```

# String literal
<div class="warning">
    Current version of aquascope cannot render string literal so we have to check the pointer.
</div>

```rust,editable
fn main(){
    let a  = "aaaa";
    let b = a;
    println!("a_ptr = {:?}", a.as_ptr());
    println!("b_ptr = {:?}", b.as_ptr());
    println!("{}", a);
    println!("{}", b);
}
```
