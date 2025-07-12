# Statement-Arguments

## Passing argument by value
By default the arguments are passed by value, but attention, as we have already seen in the previous chapter,
the operator **=** behaves differently depending on the type:

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn myfunc(arg1: u32, arg2: Vec<u32>){
    println!("{}", arg1);
    println!("{:?}", arg2);
}

fn main(){
    let mut a = 10;
    let mut b: Vec<u32> = Vec::from([1, 2, 3]);
    myfunc(a, b);

    println!("{}", a);
    println!("{:?}", b);
}
```

```rust,editable
fn myfunc(arg1: u32, arg2: Vec<u32>){
    println!("{}", arg1);
    println!("{:?}", arg2);
}

fn main(){
    let mut a = 10;
    let mut b: Vec<u32> = Vec::from([1, 2, 3]);
    myfunc(a, b);

    println!("{}", a);
    println!("{:?}", b);
}
```

## Passing argument by reference.

<div class="warning">
    Pay attention to the dereferencing operator *. It is not necessary when indexing into an Vector.
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn myfunc(arg1: &mut u32, arg2: &mut Vec<u32>){
    *arg1 += 10;
    arg2[1] += 10;
    println!("{}", *arg1);
    println!("{:?}", *arg2);
}

fn main(){
    let mut a = 10;
    let mut b: Vec<u32> = Vec::from([1, 2, 3]);
    myfunc(&mut a, &mut b);
    a += 1;
    b[0] += 1;

    println!("{}", a);
    println!("{:?}", b);
}
```

```rust,editable
fn myfunc(arg1: &mut u32, arg2: &mut Vec<u32>){
    *arg1 += 10;
    arg2[1] += 10;
    println!("{}", *arg1);
    println!("{:?}", *arg2);
}

fn main(){
    let mut a = 10;
    let mut b: Vec<u32> = Vec::from([1, 2, 3]);
    myfunc(&mut a, &mut b);
    a += 1;
    b[0] += 1;
    println!("{}", a);
    println!("{:?}", b);
}
```


