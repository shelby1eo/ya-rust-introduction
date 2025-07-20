# Methods

A Method is a function associated with a **struct**, **enum** or **trait object** and its first parameter is always **self**.

# method signature

[example from the book](https://rust-book.cs.brown.edu/ch05-03-method-syntax.html).
```rust,editable
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

impl Rectangle {
    fn width_add(&mut self, value: u32) {
        self.width = self.width + value;
    }
}

fn main() {
    let mut rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!("The area of the rectangle is {} square pixels.", rect1.area());
    rect1.width_add(10);
    println!("New width is {}.", rect1.width);
}
```

Here as per a normal function it is possible to:
- &self: borrow the value.
- self:  take ownership of the value, used rarely when transform value in something else, and want to remove access to original.
- &mut self:  borrow mutable.

# Associated functions
Def: An *associate function* is a function contained in a **impl** block. They are called associated because they are *associated* with a type.  
An associate function doesnt
Typical usage is for implementing **constructors**.  


[example from the book](https://rust-book.cs.brown.edu/ch05-03-method-syntax.html#associated-functions).
```rust,editable
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn Square(lato: u32) -> Self {
        // !!! Warning: despite the memory is moved, the mutability is decided at variable instantiation and not in the constructor.
        // let mut square = Rectangle {
        let square = Rectangle {
            width: lato,
            height: lato,
        };
        square
    }

    // More compact way to write it, note that Self is already of the type Rectangle.
    fn Square2(lato: u32) -> Self {
        Self {
            width: lato,
            height: lato,
        }
    }
}

fn main() {
    let mut mysquare = Rectangle::Square(10);
    println!("Square is {} x {} square pixels.", mysquare.width, mysquare.height);
    mysquare.width = 0;
    println!("Square is {} x {} square pixels.", mysquare.width, mysquare.height);
    let mut mysquare = Rectangle::Square2(20);
    println!("Square is {} x {} square pixels.", mysquare.width, mysquare.height);
    mysquare.width = 0;
    println!("Square is {} x {} square pixels.", mysquare.width, mysquare.height);
}
```

# mutability for a constructor
## scalar
<div class="warning">
    !!! Warning: despite returning an immutable, the mutability is decided at variable instantiation and not in the constructor.
</div>

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
        square
    }
}

fn main() {
    let mut mysquare = Rectangle::Square(10);
    println!("Square is {:?} x {:?} square pixels.",
        mysquare.width, mysquare.height);
    mysquare.width = 0;
    println!("Square is {:?} x {:?} square pixels.",
        mysquare.width, mysquare.height);
}
```
# String
<div class="warning">
    !!! Warning: despite returning an immutable, the mutability is decided at variable instantiation and not in the constructor.
</div>

```rust,editable
struct Rectangle {
    width: String,
    height: String,
}

impl Rectangle {
    fn Square(lato: String) -> Self {
        // note square is not mutable
        let square = Rectangle {
            width: lato.clone(),
            height: lato.clone(),
        };
        square
    }
}

fn main() {
    let mystring = String::from("aaaaa");
    let mut mysquare = Rectangle::Square(mystring);
    mysquare.width.push_str("bbbb");
    println!("{:?}", mysquare.width);
}
```


