# Truple

A tuple is a collection of values of different types.  
It can be useful to:
- return several variables from a function
- group variables that are logically bounded.

## return several values
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn myfunc() -> (u32, Vec<i32>) {
    let a = 42u32;
    let b = Vec::from([8, 9]);
    (a, b)
}
fn main(){
    let c = myfunc();
    println!("{:?}", c);

}
```

```rust,editable
fn myfunc() -> (u32, Vec<i32>) {
    let a = 42u32;
    let b = Vec::from([8, 9]);
    (a, b)
}
fn main(){
    let c = myfunc();
    println!("{:?}", c);

}
```

## Truple can be named

```rust,editable
fn myfunc() -> (u32, u32) {
    let coord: (u32, u32) = (1u32, 2u32);
    coord
}
fn myfunc2() -> (u32, u32) {
    let x = 4u32;
    let y = 5u32;
    let coord: (u32, u32) = (x, y);
    coord
}

fn main(){
    let c = myfunc();
    println!("{:?}", c);
    let c = myfunc2();
    println!("{}", c.0);
    println!("{}", c.1);
}
```

## as argument

```rust,editable
fn myfunc(arg1: (u32, i32)) {
    println!("{:?}", arg1);
}
fn main(){
    let c = (1, -1);
    myfunc(c);
}
```




