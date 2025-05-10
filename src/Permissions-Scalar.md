# Permissions-Scalar

## mutable reference
Very similar to the const pointer to const variable in C and C++ but the positioning of the mut keyword is more intuitive:

- **Mutable reference**: this means that the referenced memory can be modified.
```rust,editable
#![allow(unused)]
fn main() {
    let mut a = 5;
    let b = &mut a;    
    *b += 1;
}
```

- Mutable reference to immutable variable.
<div class="warning">
    unlike C and C++ where a pointer to const pointer can be still modified if the pointer get reassigned to a non-const pointer,
    rust compiler will check this and not allow it, guaranteeing memory safety.
</div>

```rust,editable
#![allow(unused)]
fn main() {
    let a = 5;
    let b = &mut a; // cannot borrow as mutable since a was declared as immutable.
    *b += 1;
}
```

- b cannot be reassigned to reference another variable, because it is immutable.
```rust,editable
#![allow(unused)]
fn main() {
    let mut a = 5;
    let mut c = 66;
    let b = &mut a; // immutable reference to mutable variable
    *b += 1;
    b = &mut c;
    *b += 1;
}
```

- When b is mutable it can be reassigned.
```rust,editable
#![allow(unused)]
fn main() {
    let mut a = 5;
    let mut c = 66;
    let mut b = &mut a; // mutable reference to mutable variable
    *b += 1;
    println!("{b}");
    b = &mut c;
    *b += 1;
    println!("{b}");
}
```

## mutable reference effects on permissions
Lets take the following 4 usecases.

| cases | Comment |
| ------------- | -------------- |
| b = &a;       |   |
| b = &mut a;   |   |
| mut b = &a;   |   |
| mut b = &mut a;|  |

### b = &a;
1. a is declared.  
2. b takes ownership of a but only with R permission.
3. **both a and b are accessible in R only.**
4. once b is last used in the current scope, a will recover its W permission.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    let b = &a;
    println!("{a}");
    println!("{b}");
    a += 1;
    println!("{a}");
}
```

### b = &mut a;
1. a is declared.
2. b takes ownership of a but only with R permission.
3. **b are accessible inre R only but a lose the R permission.**
4. once b is last used in the current scope, a will recover its W permission.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    let b = &mut a;
    // println!("{a}"); // a have losted R permission.
    println!("{b}");
    a += 1;
    println!("{a}");
}
```

### mut b = &a;
1. a is declared.
2. b takes ownership of a but only with R permission.
3. **b is reassigned to mut reference to c**.
4. **b's permission still is defined from the first assignment**

<div class="warning">
    Here a weird behaviour, since b is mutable, it should be possible to reassign it to a reference of mutable c. but
    the borrow checker do not agree with it. Is a feature or a bug?
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    let mut c = 66;
    let mut b = &a;
    // *b += 1;
    println!("{b}");
    b = &mut c;
    a += 1;
    println!("{b}");
    // *b += 1;
    println!("{b}");
}
```


```rust,editable
#![allow(unused)]
fn main() {
    let mut a = 5;
    let mut c = 66;
    let mut b = &a;
    // *b += 1;
    println!("{b}");
    b = &mut c;
    a += 1;
    println!("{b}");
    *b += 1; // this line will not compile
    println!("{b}");
}
```

### mut b = &mut a;
1. a is declared.
2. b takes ownership of a but with W permission.
3. **b is reassigned to mut reference to c**
4. **b type is decided from the first assignment**

<div class="warning">
    Here a weird behaviour: it is not possible to assign to b a non mutable c.
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a = 5;
    let mut c = 66;
    let mut b = &mut a;
    *b += 1;
    println!("{b}");
    b = &mut c;
    a += 1;
    println!("{b}");
    *b += 1;
    println!("{b}");
}
```


```rust,editable
#![allow(unused)]
fn main() {
    let mut a = 5;
    let mut c = 66;
    let mut b = &mut a;
    *b += 1;
    println!("{b}");
    b = &mut c;
    a += 1;
    println!("{b}");
    *b += 1;
    println!("{b}");
}
```

