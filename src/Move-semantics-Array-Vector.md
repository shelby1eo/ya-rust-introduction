# Array
Not much to be said here, memory allocated on the stack and the default behaviour is a copy.
In later chapter will be shown how to avoid this memory copy via **borrowing**.
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main(){
    let a = [1, 2, 3];
    let b = a;
    println!("{:?}", a);
    println!("{:?}", b);
}
```

# Vector
Finally things get interesting, in Rust when the memory is allocated on the heap the operator = will **move**
the ownership of the memory to the assigned variable, note that the original variable will not be accessible anymore:

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main(){
    let a = vec![1, 2, 3];
    let b = a;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main(){
    let a = Box::new([1, 2, 3]);
    let b = a;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main(){
    let a = Box::new([1, 2, 3]);
    let b = a;
    println!("{:?}", b);
    println!("{:?}", a); // a have lost the access on that memory this line will not compile.
}
```

