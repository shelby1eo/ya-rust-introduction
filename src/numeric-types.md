# Numeric Types
To a first glance built-in integer types are very similar to the types available in C/C++.
<span class="caption">Table 2-1: Integer Types in Rust</span>
| Length  | Signed  | Unsigned |
| ------- | ------- | -------- |
| 8-bit   | `i8`    | `u8`     |
| 16-bit  | `i16`   | `u16`    |
| 32-bit  | `i32`   | `u32`    |
| 64-bit  | `i64`   | `u64`    |
| 128-bit | `i128`  | `u128`   |
| arch-bit| `isize` | `usize`  |

## u32 basics
Actually rust build-in types are basically classes [std u32](https://doc.rust-lang.org/std/primitive.u32.html).  

Rust does most of the checks in compiling time, try to execute the following code blocks.  

When possible overflow are detected at compile time.  
```rust,editable
fn main() {
    let a = 200u8;  // type specified
    let b = 200;    // type inference
    let _c = a + b;
}
```
The default reaction of rust is to panic in case of runtime error.  
```rust,editable
#![feature(strict_overflow_ops)]
fn main() {
    let a = 200u8;
    let b = 200u8;
    let _c = a.strict_add(b);
}
```

Types are more similar to classes with convenient basic functionalities.  
```rust,editable
fn main() {
    let a = 200u8;
    let b = 200u8;
    let c = a.saturating_add(b);
    println!("{c}");
}
```

```rust,editable
fn main() {
    let a = 200u8;                  // by default all variables are immutable
    let mut c = a.checked_add(1);   // mut: to declare a mutable variable
    println!("{:?}", c);

    let mut c = (u32::MAX - 2).checked_add(3);
    println!("{:?}", c);
}
```
