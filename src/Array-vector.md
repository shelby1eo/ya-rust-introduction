# Array/Vector

Stack is faster, but it size need to be fixed at compilation time.
Heap is more flexible (e.g. can be grown) but it is more costly in term of access time.

Array are located in the Stack:
```aquascope,interpreter,horizontal
#fn main() {
    // different way to declare arrays:
    let mut array: [i32; 3] = [0; 3];
    let bytes: [u8; 3] = [1, 0, 2];
    // let ji = ["Pollo", "Chicken", "Pavo"]; // unfortunately aquascope cannot render array of string.
    array[0] = 5;
#}
```

Array cannot be grown, but you can slice it:
```rust,editable
fn main() {
    let ji = ["Pollo", "Chicken", "Pavo", "Poulet"];
    let dinner = &ji[0 .. 3];
    println!("{:?}", ji);
    println!("{:#?}", dinner);
}
```

It is possible to put the variable into the heap:
- Box: more efficient, efficient when want to transfer ownership of big data.
- Vec: growable, has more feature than Box with the cost of using more memory.
```aquascope,interpreter,horizontal
#fn main() {
    // let boxed_slice: Box<[u8]> = vec![0; 100_000_000].into_boxed_slice(); // cannot be rendered
    // let array2: Box<[i32]> = Box::new([1,2,3]); // cannot be rendered
    let box: Box<u8> = Box::new(1);
    let mut vec: Vec<i32> = Vec::new();
    vec.push(1);
    //  box.push(2); // box do not have push
#}
```

Vec are over allocated because when reaching its maximun size the full array need to be reallocated and the memory copied.:
```aquascope,interpreter,horizontal
#fn main() {
    let mut vec = Vec::new();
    vec.push(1);
    vec.push(1);
    vec.push(1);
    vec.push(1);
    vec.push(1);
#}
```

Play here:
```rust,editable
#![allow(unused)]
#![feature(vec_into_raw_parts)]
fn main() {
    let mut array: [i32; 3] = [0; 3];
    let bytes: [u8; 3] = [1, 0, 2];
    let months = ["Pollo", "Chicken", "Pavo"];
    array[0] = 5;
    let boxed_slice: Box<[u8]> = vec![0; 100_000_000].into_boxed_slice();
    let array2: Box<[i32]> = Box::new([1,2,3]);

    // demo memory reallocation:
    let mut vec = Vec::new();
    let vec_ptr = vec.as_ptr();
    println!("pointer to non allocated memory to address {:?}", vec_ptr);
    vec.push(1); // by default this will over allocate a capacity of 4
    // allocate vec2 order to occupy the memory after vec so it will be forced to reallocate once hit the size 4
    let mut vec2 = Vec::new();
    vec2.push(5);
    let mut vec_ptr = vec.as_ptr(); // aliasing
    println!("1: {:?}", vec_ptr);
    vec.push(1);
    vec_ptr = vec.as_ptr();
    println!("2: {:?}", vec_ptr);
    vec.push(1);
    vec_ptr = vec.as_ptr();
    println!("3: {:?}", vec_ptr);
    vec.push(1);
    vec_ptr = vec.as_ptr();
    println!("4: {:?}", vec_ptr);
    vec.push(1);
    vec_ptr = vec.as_ptr();
    println!("5: cap is hit, reallocation and copy {:?}", vec_ptr);
    vec.push(1);
    vec_ptr = vec.as_ptr();
    println!("6: {:?}", vec_ptr);
}
```

<div class="warning">
    the Rust syntax, is very explicit, this is one of the biggest complain about rust, but argubly it has its advantages.
    in the same time it is just straight forward WEIRD!!!
    look to the following two examples:
</div>

std::vec and std:boxed are logically related related, one is growable the other is not.  
but the init syntax is very different:
```rust,editable
fn main() {
    // std::vec init with no elements:
    let mut a: Vec<i32> = Vec::new();
    // std::vec init with elements:
    let mut a: Vec<i32> = Vec::from([1,2,3]);
    // std::vec init with element simplified by a macro:
    let mut a: Vec<i32> = vec![1,2,3];
    // std::boxed has predefined size
    // the type and the declaration looks so different!!!
    let mut a: Box<[i32]> = Box::new([1,2,3]);
}
```

