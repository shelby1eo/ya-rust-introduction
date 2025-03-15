# Introduction
In a world where AI suppose to write code instead of you, to replace teachers, friends and lovers.  
This book is an [rubberducking](https://en.wikipedia.org/wiki/Rubber_duck_debugging) for me to learn rust.  
Someone told me once, when you can explain complicated concept in such way that others can understand easily
then you have mastered that concept (I don't remember who told me that).

The original idea was to touch those fundamental Rust concepts in order to facilitate the first impact
of someone who have just started with Rust.

When possible i will try to link directly the Rust Book in order to avoid duplication.  
A lot is inspired by the official learning materials provided by Rust, please read them they are the best.  
- [Rust Book](https://rust-book.cs.brown.edu/experiment-intro.html) 
- [Rust By Example](https://doc.rust-lang.org/rust-by-example/) 
- [Learn Rust](https://www.rust-lang.org/learn) 
- [The Rust Reference](https://doc.rust-lang.org/reference/introduction.html) 

## why rust?
Frankly there are too many video already available online 🤯.  
- [Rust in 100s](https://youtu.be/5C_HPTJg5ek?si=polghETkYUJKbShi) 
- [The History of Rust](https://youtu.be/79PSagCD_AY?si=AwGw05OVbq85CZqr) 
- [Interview with Senior Rust Developer](https://www.youtube.com/watch?v=TGfQu0bQTKc) 

A non exaustive list of good reasons:
- Good defaults.
- Restrictive but still possible to opt out.
- Safe defined as non Undefined Behaviour.
- Good tooling.
- Maximized checks on compile time.

Some personal opinion:
There is a good complain in the community that rust is slow to compile compared to C++,
I would argument that the C++ compiler time is even longer: in order to make a safe C++ code it is necessary to run Static Code Analysis
and Dynamic Code Analysis, since for each of this tool have several vendors that give different results, you may need to run more than one,
now sum the time needed to run all this tools and the effort to rework the code to make it conform to the findings and you will have your answer
of which language is the slowest to compile.

I am gloss over the huge effort of maintaining the tooling for C/C++ ultimately making the language inefficient:
- make, ninja, CMake, Bazel, Mason.
- [list Static Code Analysis](https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis) 
- [Clang tools](https://clang.llvm.org/docs/index.html) 
- almost for each Clang tool gcc has an equivalent.

Rust Lang shakes away that constant fear of shooting yourself on the foot.
