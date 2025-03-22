# VariablesDifferent way 
## Declaration
```rust,editable
// print_type_of ref: ref: https://stackoverflow.com/questions/21747136/how-do-i-print-the-type-of-a-variable-in-rust
fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>());
}

fn main() {
    // The type is specified after the variable name.
    let a: u8 = 42;
    print_type_of(&a);
    // i32 is the default if not specified.
    let a = 42; 
    print_type_of(&a);
    // type can be coerced.
    let a = 42u64;
    print_type_of(&a);
}
```
## Mutability
Variable is inmutable by default, followinf code will fail:
```rust,editable
fn main() {
    let a  = 3;
    a = 6;
}

```
mut is used to make a variable mutable:
```rust,editable
fn main() {
    let mut a  = 3;
    a = 6;
}
```
## Scope & shadowing
Variables can be shadowed: it is possible to declare the same variable name, following portion of the code will only see the last declaration.
```rust,editable
fn main() {
    let a:i32  = 1; let a_ptr: *const i32 = &a;
    println!("{} {:?}", a, a_ptr);
    let a: f32  = 2.0; let a_ptr: *const f32 = &a;
    println!("{} {:?}", a, a_ptr);
    let a  = 3u64; let a_ptr: *const u64 = &a;
    println!("{} {:?}", a, a_ptr);
}
```
Scope works similar to C++ which is the secrion contained by a {}
```rust,editable
fn main() {
    let a:i32  = 1; let a_ptr: *const i32 = &a;
    println!("{} {:?}", a, a_ptr);
    let a: f32  = 2.0; let a_ptr: *const f32 = &a;
    println!("{} {:?}", a, a_ptr);
    {
        // this is a different scope, variables declated here are droped at the end of it.
        let a  = 3u64; let a_ptr: *const u64 = &a;
        println!("{} {:?}", a, a_ptr);
    }
    println!("{} {:?}", a, a_ptr);
}
```
