# Statement-Return

## keyword return
The keyword **return** is not necessary for returning expression at the end of the scope.
The keyword **return** can be used if to return before the end of the scope.

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

# Return a Turple Unit
[*The tuple without any values has a special name, unit.  
This value and its corresponding type are both written () and represent an empty value or an empty return type.
Expressions implicitly return the unit value if they don’t return any other value.*](https://rust-book.cs.brown.edu/ch03-02-data-types.html#the-tuple-type).

ToDo: Complete this part.

ref:[diem](https://diem.github.io/move/tuples.html)

# Return a Unit-Like Structs
[*You can also define structs that don’t have any fields!
These are called unit-like structs because they behave similarly to (),
the unit type that we mentioned in “The Tuple Type” section. 
Unit-like structs can be useful when you need to implement a trait on some type but don’t have any data that you want to store in the type itself.
We’ll discuss traits in Chapter 10.*](https://rust-book.cs.brown.edu/ch05-01-defining-structs.html#unit-like-structs-without-any-fields).

ToDo: Complete this part.



