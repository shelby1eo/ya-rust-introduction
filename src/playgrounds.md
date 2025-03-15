## Playground
For those that want to have an initial taste of Rust and who want to avoid the hustle to setup the there are a couple of possible playgrounds.

### mdbook playground
You can edit and run rust code directly in the editable code block:

```rust,editable
fn main() {
    // you can modify the code here!
    println!("Hello World!");
}
```

### Container
You can use the container provided with the [repository](https://github.com/shelby1eo/ya-rust-introduction) of this book.  

```bash
git clone https://github.com/shelby1eo/ya-rust-introduction
cd ya-rust-introduction
make all-interactive
cd examples/hello-world/
cargo build
cargo run
```

### Aquascope Playground
cognitive-engineering-lab provides an interactive visualizations of Rust programs called [Aquascope Playground](https://cel.cs.brown.edu/aquascope/).  

### Install on your own host
Please follow the instruction provided by your distribution, here some good link:  
[nixos rust Installation](https://wiki.nixos.org/wiki/Rust)  
[Rust book chapter Installation](https://rust-book.cs.brown.edu/ch01-01-installation.html)  
