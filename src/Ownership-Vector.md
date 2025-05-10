# Vector
Since **String** is just a wrapper to **Vec**, it will be omitted in this chapter.  

## Assignment operator =
The ownership is moved to b and at the end of its scope the memory is dropped.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: Vec<i32> = Vec::new();
    a.push(1);
    println!("{:?}", a);
    {
        let mut b = a;
        b.push(2);
        println!("{:?}", b);
    }
    // println!("{:?}", b);
    // println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::new();
    a.push(1);
    println!("{:?}", a);
    {
        let mut b = a;
        b.push(2);
        println!("{:?}", b);
    }
    // println!("{:?}", b);
    // println!("{:?}", a);
}
```

## Borrow operator &

At the end of the scope of *b* the ownership is returned to a.
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: Vec<i32> = Vec::new();
    a.push(1);
    println!("{:?}", a);
    {
        let b = &mut a;
        b.push(2);
        println!("{:?}", b);
    }
    // println!("{:?}", b);
    println!("{:?}", a);
}
```

```rust,editable
fn main() {
    let mut a: Vec<i32> = Vec::new();
    a.push(1);
    println!("{:?}", a);
    {
        let b = &mut a;
        b.push(2);
        println!("{:?}", b);
    }
    // println!("{:?}", b);
    println!("{:?}", a);
}
```

