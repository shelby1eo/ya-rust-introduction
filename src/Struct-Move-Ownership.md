# Move & Ownership

The assignment of a struct will depend on the type of the field.

# basic struct

<div class="warning">
    This is a usecase where Rust is confusiong, so even if the mysquare is stored in the stack.
    The assignment operator will move the struct, but if you try to print the raw pointers,
    they will be pointing to DIFFERENT addresses.
</div>

This example will fail because accessing value after move:
```rust,editable
struct Rectangle {
    width: u32,
    height: u32,
}

fn main() {
    let mysquare = Rectangle {
        width: 5,
        height: 5,
    };
    println!("{:?}", mysquare.width);
    let mysquare2 = mysquare;
    println!("{:?}", mysquare.width);
    println!("{:?}", mysquare2.width);
}
```

This example show the raw pointer addresses which surprisingly are different:
```rust,editable
struct Rectangle {
    width: u32,
    height: u32,
}

fn main() {
    let mysquare = Rectangle {
        width: 5,
        height: 5,
    };
    let raw = &mysquare as *const Rectangle;
    let raw2 = &mysquare.width as *const u32;
    println!("{:?}", raw);
    println!("{:?}", raw2);
    let mysquare2 = mysquare;

    let raw = &mysquare2 as *const Rectangle;
    let raw2 = &mysquare2.width as *const u32;
    println!("{:?}", raw);
    println!("{:?}", raw2);
}
```

Copy treat can be derived automatically:
```rust,editable
#[derive(Copy, Clone)]
struct Rectangle {
    width: u32,
    height: u32,
}

fn main() {
    let mysquare = Rectangle {
        width: 5,
        height: 5,
    };
    println!("{:?}", mysquare.width);
    let mysquare2 = mysquare;
    println!("{:?}", mysquare.width);
    println!("{:?}", mysquare2.width);
}
```

# Move is the default for Tuple Struct
<div class="warning">
    The assignment of a Tuple Struct will do a Move!
</div>

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);
struct Retangle {
    width: u32,
    height: u32,
}

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    let retangle = Retangle {
        width: 10,
        height: 20,
    };
    let point1 = origin;
    let retangle1 = retangle;
    println!("{:?}", black.0);
    println!("{:?}", origin.0);
    println!("{:?}", point1.0);
    println!("{:?}", retangle.width);
    println!("{:?}", retangle1.width);
}
```

```rust,editable
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);
struct Retangle {
    width: u32,
    height: u32,
}

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    let retangle = Retangle {
        width: 10,
        height: 20,
    };
    let point1 = origin;
    let retangle1 = retangle;
    println!("{:?}", black.0);
    // println!("{:?}", origin.0);
    println!("{:?}", point1.0);
    println!("{:?}", retangle.width);
    println!("{:?}", retangle1.width);
}
```

# example with String
A Struct will move consistently its fields instead of the tuple which will move or copy depending on the type,
it is arguably clearer.

```aquascope,interpreter+permissions,boundaries,stepper,horizontal
struct pokemon {
    name: String,
    hp: u32,
}

fn main() {
    let pikachu = pokemon {
        name: String::from("Pikachu"),
        hp: 1,
    };
    let pika2 = pikachu;
}
```

```rust,editable
struct Pokemon {
    name: String,
    hp: u32,
}

fn main() {
    let pikachu = Pokemon {
        name: String::from("Pikachu"),
        hp: 1,
    };
    let pika2 = pikachu;
    // println!("{:?}", pikachu.name);
    println!("{:?}", pika2.name);
}
```

# example with constructors
## Scalar
```rust,editable
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn Square(lato: u32) -> Self {
        // !!! square is declared imutable here !!!
        let square = Rectangle {
            width: lato,
            height: lato,
        };
        let raw = &(square.width) as *const u32;
        println!("width raw ptr  {:?}", raw);
        square
    }
}

fn main() {
    let mut mysquare = Rectangle::Square(10);
    println!("Square is {:?} x {:?} square pixels.",
        mysquare.width, mysquare.height);
    let raw = &mysquare.width as *const u32;
    println!("width raw ptr {:?}", raw);
    println!("Two pointers expected to point to DIFFERENT addresses")

}
```

## String
```rust,editable
struct Rectangle {
    width: String,
    height: String,
}

impl Rectangle {
    fn Square(lato: String) -> Self {
        let square = Rectangle {
            width: lato.clone(),
            height: lato.clone(),
        };
        println!("width raw ptr  {:?}", square.width.as_ptr());
        square
    }
}

fn main() {
    let mystring = String::from("aaaaa");
    let mysquare = Rectangle::Square(mystring);
    println!("width raw ptr {:?}", mysquare.width.as_ptr());
    println!("Two pointers expected to point to SAME address")
}
```

# Struct Store references

<div class="warning">
    When Struct store reference instead of owning the memory it will make use of lifetime inorder to garantee
    memory safety.  
    You may want to come back here after the chapter on lifetime.
</div>

ToDo: come back here are write the chapter after the lifetime is written :P
