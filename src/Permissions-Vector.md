# Permissions-Vector
Since **String** is just a wrapper to **Vec**, it will be omitted in this chapter.  

## mutable reference effects on permissions

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
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let b = &a;
    // b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let b = &a;
    // b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

### b = &mut a;
1. a is declared.
2. b takes ownership of a but only with R permission.
3. **b are accessible inre R only but a lose the R permission.**
4. once b is last used in the current scope, a will recover its W permission.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let b = &mut a;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let b = &mut a;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
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
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &a;
    let mut c: Vec<i32> = Vec::from([4, 5, 6]);
    //b[0] += 1;
    b = &mut c;
    //b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &a;
    let mut c: Vec<i32> = Vec::from([4, 5, 6]);
    //b[0] += 1;
    b = &mut c;
    //b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

<div class="warning">
    As opposed of Arrays Vector can re-reference to Vectors of different sizes.
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &a;
    let mut c: Vec<i32> = Vec::from([4, 5]);
    b = &mut c;
}
```
```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &a;
    let mut c: Vec<i32> = Vec::from([4, 5]);
    b = &mut c;
}
```

### mut b = &mut a;
1. a is declared.
2. b takes ownership of a but with W permission.
3. **b is reassigned to mut reference to c**
4. **b type is decided from the first assignment**

<div class="warning">
    Here a weird behaviour, since b is mutable, it should be possible to reassign it to a reference of mutable c. but
    the borrow checker do not agree with it. Is a feature or a bug?
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &mut a;
    let mut c: Vec<i32> = Vec::from([4, 5]);
    b[0] += 1;
    b = &mut c;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::from([1, 2, 3]);
    let mut b = &mut a;
    let mut c: Vec<i32> = Vec::from([4, 5]);
    b[0] += 1;
    b = &mut c;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

