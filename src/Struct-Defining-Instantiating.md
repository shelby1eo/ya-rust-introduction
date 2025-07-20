# Defining-Instantiating

Note: The corresponding chapter in **The Rust book** is extremely clear,
feel free to jump to the link [click here](https://rust-book.cs.brown.edu/ch05-01-defining-structs.html).  
This chapter will have the same content with misspellings XD ... I am still doing it because this will help me to digest the concept.

## basics
The instance can be either entirely mutable or immutable, it is not possible to specified mutability for fields.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
struct Pokemon {
    name: String,
    type1: String,
    hp: u8,
    status: String,
}

fn main(){
    let mut pkm1 = Pokemon {
        name: String::from("Swinub"),
        type1: String::from("Ice"),
        hp: 100u8,
        status: String::from("none"),
    };
    pkm1.status = String::from("Paralized");
    println!("{}", pkm1.name);
    println!("{}", pkm1.status);
}```

```rust,editable
struct Pokemon {
    name: String,
    type1: String,
    hp: u8,
    status: String,
}

fn main(){
    let mut pkm1 = Pokemon {
        name: String::from("Swinub"),
        status: String::from("none"),
    };
    println!("Notice that here the memory get reallocated on the heap");
    println!("{:?}", pkm1.status.as_ptr());
    pkm1.status = String::from("Paralized");
    println!("{:?}", pkm1.status.as_ptr());
    println!("{}", pkm1.name);
    println!("{}", pkm1.status);
}
```
## Field Init Shorthand Syntax
There is a compact syntax that would avoid repetition, when the field has the same name as a variable.
This can be useful when creating a builder function.

```rust,editable
struct Pokemon {
    name: String,
    status: String,
}

fn builder_pkm(name: String, status: String) -> Pokemon {
    let mut pkm = Pokemon {
        name,
        status,
    };
    pkm
}

fn main(){
    let name = String::from("Geodude");
    let mut pkm1 = Pokemon {
        name,
        status: String::from("none"),
    };
    println!("{}", pkm1.name);
    let mut pkm2 = builder_pkm(String::from("Slugma"), String::from("Poisoned"));
    println!("{}", pkm2.name);
}
```

## Struct Update Syntax
In order to instantiate and initialize a Struct with another you need either to initiate each field, direct assignment is not allowed.
The Struct Update Syntax is a compact way that help to declare struct of the same type by avoid to specify field per field.  
Be careful if one of the fields contains a type that do not implement the copy treat then the memory will be moved.  
- [explanation of copy and clone](https://oswalt.dev/2023/12/copy-and-clone-in-rust/)  

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
struct Pokemon {
    name: String,
    status: String,
    hp: u8,
}

fn main(){
    let name = String::from("Geodude");
    let mut pkm1 = Pokemon {
        name,
        status: String::from("none"),
        hp = 100u8,
    };
    let mut pkm2 = Pokemon {
        name: String::from("Slugma"),
        ..pkm1
    };
    println!("{}", pkm1.name);
    println!("{}", pkm2.name);
    println!("{}", pkm1.status);
}
```

```rust,editable
struct Pokemon {
    name: String,
    status: String,
    hp: u8,
}

fn main(){
    let name = String::from("Geodude");
    let mut pkm1 = Pokemon {
        name,
        status: String::from("none"),
        hp: 100u8,
    };
    let mut pkm2 = Pokemon {
        name: String::from("Slugma"),
        ..pkm1
    };
    println!("{}", pkm1.name);
    println!("{}", pkm2.name);
    println!("{}", pkm1.status);
}
```

## Tuple Struct
*Using Tuple Structs Without Named Fields to Create Different Types.*
*Tuple Structs are useful when you want to give the whole tuple a name and make the tuple a
different type from other tuples, and when naming each field as in a regular 
Struct would be verbose or redundant.*

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    println!("{:?}", black.0);
    println!("{:?}", origin.0);
}
```

```rust,editable
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    println!("{:?}", black.0);
    println!("{:?}", origin.0);
}

```

## Unit-Like Structs
[Unit-Like Structs (Without Any Fields).](https://rust-book.cs.brown.edu/ch05-01-defining-structs.html#unit-like-structs-without-any-fields).  
Do not worry about them until the chapter on traits.

```rust,editable
struct AlwaysEqual;
fn main() {
    let subject = AlwaysEqual;
}
```

