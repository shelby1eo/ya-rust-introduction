# Scalar

# Assignment operator =

Not much to be said about **Simple Assignment:** of a scalar, It is a copy the memory to another address on the stack. No ownership is transferred.
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    println!("{a}");
    let mut b = a;
    a = 2;
    b = 1;
}
```

# Borrow operator &
<div class="warning">
    In rust the borrow-operator '&' and the derefence-operator '*' have very different meaning compare to C and C++,
    in rust & will also transfer the Ownership of the memory to the assigned variable.

ref: [rust-lang borrow operator &](https://doc.rust-lang.org/reference/expressions/operator-expr.html#r-expr.operator.borrow).
ref: [rust-lang dereference operator *](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-dereference-operator).
</div>

rust-lang defines the scope as:
["A scope is the region of source text where a named entity may be referenced with that name."](https://doc.rust-lang.org/reference/names/scopes.html)  
To keep it simple know a scope is the text enclosed by a pair of braces `{}` or when the variable is last used.

At the end of the scope of *b* the ownership is returned to a.
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    println!("{a}");
    {
        let b = &mut a;
        *b = 1;
        // println!("{a}");
        println!("{b}");
        println!("{}", *b);
    }
    println!("{a}");
}
```

```rust,editable
fn main() {
    let mut a = 5;
    println!("{a}");
    {
        let b = &mut a; // the ownership of the memory of a is transferred to b.
        *b = 1;
        // a is not accessible because memory ownership is transfer to b
        // println!("{a}"); // !!! try to uncomment this line.
        println!("{b}");
        println!("{}", *b);
        // b goes out of the scope, so a regain the ownership.
    }
    println!("{a}");
}
```







