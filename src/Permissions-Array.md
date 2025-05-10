# Permissions-Array

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
    let mut a: [u8; 3] = [2; 3];
    let b = &a;
    // b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
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
    let mut a: [u8; 3] = [2; 3];
    let b = &mut a;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
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
    let mut a: [u8; 3] = [2; 3];
    let mut b = &a;
    let mut c: [u8; 3] = [1; 3];
    //b[0] += 1;
    b = &mut c;
    //b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
    let mut b = &a;
    let mut c: [u8; 3] = [1; 3];
    //b[0] += 1;
    b = &mut c;
    //b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

<div class="warning">
    When reassiging the reference it must have the same size of the first assignment.
</div>

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
    let mut b = &a;
    let mut c: [u8; 3] = [1; 3];
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
    let mut a: [u8; 3] = [2; 3];
    let mut b = &mut a;
    let mut c: [u8; 3] = [1; 3];
    b[0] += 1;
    b = &mut c;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
    let mut b = &mut a;
    let mut c: [u8; 3] = [1; 3];
    b[0] += 1;
    b = &mut c;
    b[0] += 1;
    println!("{:?}", b);
    println!("{:?}", a);
}
```
## variable scope
Since arrays are store in the stack the behaviour is similar to the scalar variables.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: [u8; 3] = [2; 3];
    println!("{:?}", a);
    {
        let b = &mut a;
        b[0] += 1;
        println!("{:?}", b);
    }
    // println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: [u8; 3] = [2; 3];
    println!("{:?}", a);
    {
        let b = &mut a;
        b[0] += 1;
        println!("{:?}", b);
    }
    // println!("{:?}," b); // b is out of the scope and the memory is freed.
    println!("{:?}", a);
}
```

