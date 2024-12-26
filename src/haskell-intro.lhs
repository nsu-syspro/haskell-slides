---
title: Introduction to Haskell
subtitle: Functional programming in Haskell
---

What is Haskell?
================

. . .

::: columns
:::: {.column width=50%}

Functional \phantom{y} \centering
----------

- Functions as first-class citizens
- Higher order functions
- Declarative style

. . .

Pure \phantom{y} \centering
----

- Side-effect separation
- Equational reasoning
- Simplified parallelism

. . .

::::
:::: {.column width=50%}

Lazy \centering
----

- Infinite data structures
- Compositional programming style
- Tricky to evaluate complexity

. . .

Statically typed \centering
----------------

- "If a program compiles, it probably works"
- Expressive type system
- Type inference

::::
:::

Basics
======

Anatomy of declaration \centering
----------------------

::: columns
:::: column

Here is sample Haskell declaration:

> x :: Int   -- Type declaration
> x = 42     -- Value declaration

\lstset{style=highlight}

`name = expression` is a *binding*  (not assignment)

- `::` reads as "has type"
- `=`  reads as "defined to be"

::::
:::: column

. . .

Multiple declarations with the same name are not allowed!  
Compiler will let us know about it with error:
```{style=error}
  Multiple declarations of 'x'
```

. . .

What does this declaration mean?  
And what is its type if any?

> y = y + 1

. . .

\vspace{-.8\baselineskip}

> y :: Int

::::
:::

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
