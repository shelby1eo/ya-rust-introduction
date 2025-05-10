# Statement-Expression

## some theory
Rust is a [expression-based language](https://en.wikipedia.org/wiki/Expression-oriented_programming_language).
Fundamental definitions are:
- **Statements**: are instructions that perform some action and do not return a value.
```rust
let a = 1; // is an statement.
```
```rust
let a = (let b = 1); // since it do not return anything, a statement cannot be part of an assignment.
```
- **Expressions**: evaluate to a resultant value.
```rust
let a = {
    let b = 1;
    b + 1 // this is an expression.
    // an expression at the end of a scope is the return value of the scope.
};
```
```rust
let a: u32 = {
    let b = 1u32;
    b + 1; // the semicolon at the end transforms an Expression into a Statement.
};
```
For details please check the [Rust Book](https://rust-book.cs.brown.edu/ch03-03-how-functions-work.html).


