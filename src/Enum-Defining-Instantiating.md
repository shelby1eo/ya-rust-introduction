# Enum-Defining-Instantiating

The example here are closely inspired by the [ref: rust Book](https://rust-book.cs.brown.edu/ch06-01-defining-an-enum.html). 
Feel free to read from the original material.

Def: Enums give you a way of saying a value is one of a possible set of values. E.g.:

# Enum signature
```rust,editable
enum IpAddrKind {
    V4,
    V6,
}

fn main() {
    let shape1 = IpAddrKind::V4;
    let shape1 = IpAddrKind::V6;
}

```
# More powerful Enum than C/C++
A usage of the enum could have been:

```rust,editable
enum IpAddrKind {
    V4,
    V6,
}

struct IpAddr {
    kind: IpAddrKind,
    address: String,
}

fn main() {
    let lookback = IpAddr {
        kind: IpAddrKind::V4,
        address: String::from("127.0.0.1"),
    };
    let server = IpAddr {
        kind: IpAddrKind::V6,
        address: String::from("192.168.0.2"),
    };
}

```

In Rust **enum can be of any type**, we can simplify the previous example as following

```rust,editable
enum IpAddrKind {
    V4(String),
    V4Tuple(u8, u8, u8, u8),
    V6(String),
}

fn main() {
    let lookback = IpAddrKind::V4(String::from("127.0.0.1"));
    let server = IpAddrKind::V6(String::from("2001:db8:85a3:8d3:1319:8a2e:370:7348"));
    let server_tuple = IpAddrKind::V4Tuple(192,0,0,2);
}

```

Enum can also hold struct.
```runst,editable
struct Ipv4Addr {
    // --snip--
}

struct Ipv6Addr {
    // --snip--
}

enum IpAddr {
    V4(Ipv4Addr),
    V6(Ipv6Addr),
}
```

It is possible to declare struct within the Enum declaration, in this case the type are strictly bounded to the Enum himself.
```rust,editable
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```
- Quit: Has no data associated with it at all
- Move: Has named fields, like a struct does
- Write: Includes a single String
- ChangeColor: Includes three i32 values

Of course it is possible to express the samething in struct 
```rust,editable
struct QuitMessage; // unit struct
struct MoveMessage {
    x: i32,
    y: i32,
}
struct WriteMessage(String); // tuple struct
struct ChangeColorMessage(i32, i32, i32); // tuple struct
```

The Enum give us better tools to abstract our code:
```rust,editable
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

fn send_message (message: &Message) {
    // ...
}
```

# Method
It is possible to declare method also for Enum.
```rust,editable
    impl Message {
        fn call(&self) {
            // method body would be defined here
        }
    }

    let m = Message::Write(String::from("hello"));
    m.call();
```

