# Array/Vector

Stack is faster, but it size need to be fixed at compilation time.
Heap is more flexible (e.g. can be grown) but it is more costly in term of access time.

Array are located in the Stack:
```aquascope,interpreter
#fn main() {
    // different way to declare arrays:
    let mut array: [i32; 3] = [0; 3];
    let bytes: [u8; 3] = [1, 0, 2];
    // let ji = ["Pollo", "Chicken", "Pavo"]; // unfortunately aquascope cannot render array of string.
    array[0] = 5;
#}
```

Array are cannot be grown, but you can slice it:
```rust,editable
fn main() {
    let ji = ["Pollo", "Chicken", "Pavo", "Poulet"];
    let dinner = &ji[0 .. 3];
    println!("{:?}", ji);
    println!("{:#?}", dinner);
    let myVar: Box<u8> = Box::new(1);
}
```

It is possible to put the variable into the heap:
- Box: more efficient, efficient when want to transfer ownership of big data.
- Vec: growable, has more feature than Box with the cost of using more memory.
```aquascope,interpreter
#fn main() {
    // let boxed_slice: Box<[u8]> = vec![0; 100_000_000].into_boxed_slice(); // cannot be rendered
    // let array2: Box<[i32]> = Box::new([1,2,3]); // cannot be rendered
    let box: Box<u8> = Box::new(1);
    let mut vec = Vec::new();
    vec.push(1);
#}
```

Play here:
```rust,editable
fn main() {
    let mut array: [i32; 3] = [0; 3];
    let bytes: [u8; 3] = [1, 0, 2];
    let months = ["Pollo", "Chicken", "Pavo"];
    array[0] = 5;
    let boxed_slice: Box<[u8]> = vec![0; 100_000_000].into_boxed_slice(); // cannot be rendered
    let array2: Box<[i32]> = Box::new([1,2,3]); // cannot be rendered
}
```

