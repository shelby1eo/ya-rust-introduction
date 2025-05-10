# Annex-1

The documentation of the interpreter aquascope do not document the options, here are some example of usage.

## interpreter

aquascope,interpreter,horizontal
```aquascope,interpreter,horizontal
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```

aquascope,interpreter,concreteTypes
```aquascope,interpreter,concreteTypes
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```

aquascope,interpreter+permissions,boundaries,stepper,horizontal
```aquascope,interpreter+permissions,boundaries,stepper,horizontal
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```

## permissions
aquascope,permissions,stepper
```aquascope,permissions,stepper
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```

aquascope,permissions,boundaries,showFlows
```aquascope,permissions,boundaries,showFlows
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```

aquascope,permissions,boundaries,stepper
```aquascope,permissions,boundaries,stepper
fn my_function(mut my_arg1: &String) {
    println!("{}", my_arg1);
}
fn main() {
    let mut a = String::from("chicken");
    my_function(&a);
}

```


