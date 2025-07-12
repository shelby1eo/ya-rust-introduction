# Array

## Assignment operator =
Not much to be said about Simple Assignment: of a scalar, It is a copy the memory to another address on the stack. No ownership is transferred.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: [u8; 3] = [3; 3];
    println!("{:?}", a);
    {
        let mut b = a;
        b[1] = 1;
    }
    a[1] = 1;
}
```

## Borrow operator &
**By borrowing it is possible to avoid unnecessary memory copy:**.  
At the end of the scope of *b* the ownership is returned to a.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn main() {
    let mut a: [u8; 3] = [2; 3];
    {
        let b = &a;
        println!("{:?}", b);
    }
    println!("{:?}", a);
}
```


