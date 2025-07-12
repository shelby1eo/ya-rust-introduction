# Statement-Signature

## basic function signature
The order of the variable name and the type is different that C and C++, it is positioned in order to allow you to read from left to right.  

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn my_function(my_arg1: u32) -> u32 {
    if my_arg1 > 10 {
        // return keyword can be used for early return.
        return my_arg1 - 1;
    }
    // return and semicolon can be omitted.
    my_arg1 + 1 
}
fn main() {
    // modify the value of a and try to execute this code.
    let a = 10u32;
    let b = my_function(a);
    println!("{}", b);
}
```

```rust,editable
fn my_function(my_arg1: u32) -> u32 {
    if my_arg1 > 10 {
        // return keyword can be used for early return.
        return my_arg1 - 1;
    }
    // return and semicolon can be omitted.
    my_arg1 + 1 
}
fn main() {
    // modify the value of a and try to execute this code.
    let a = 10u32;
    let b = my_function(a);
    println!("{}", b);
}

```


