# Permissions
By default in rust all variables are not mutable which means that they have only read permissions.  
Immutable variables enable the compiler to better optimize the code.  
It is arguably a best practice in any programming language to make mutable variable only when it is necessary, defaulting to this behaviour avoid you to add const or constexpr infromt of all variable declaration therefore making the code cleaner.  


<div class="warning">
    When borrowing, depending on the mutability of the variable and the borrow variable it may remove the **Read** access from the original variable. Extensive examples are provided in the chapter.
</div>

