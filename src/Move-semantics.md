# move-semantics
The title is a little misleading in this chapter we will focus on what the assignment operator **=** .  

In Cpp there is the concept of move semantic for those familiar with it here some more readings:
- [move constructor cppreference](https://en.cppreference.com/w/cpp/language/move_constructor.html)
- [move semantics from irkos.org](https://irkos.org/cpp/move/)

Long Story Short, the move semantics move the ownership of heap allocated memory to the variable that is assigned to.
The concept is the same as in C++ but rust have it as default behaviour so no need of extra syntax.
For sake of optimization copy are avoided, but if necessary it need to be explicit.

| type | behaviour | comment |
| ----   | ---- | ---- |
| scalar | copy |      |
| array  | copy |      |
| vector | move | The original variable is not accessible anymore |
| String | move | The original variable is not accessible anymore |
| String literal | copy | |

<div class="warning">
    In the string literal the data is not copied, only the memory related to the type get copied, in other word the pointer.
</div>

