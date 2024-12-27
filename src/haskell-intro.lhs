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

Basics {.t}
======

```{=latex}
\vspace{-2em}
\begin{minipage}[t][.8\textheight][t]{\linewidth}
```

. . .

```{=latex}
\begin{onlyenv}<.-.(4)>
```

::::: block

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

:::::

```{=latex}
\end{onlyenv}
```

. . .

::::: block

Built-in types \centering
--------------

. . .

```{=latex}
\begin{onlyenv}<.-.(2)>
```

::: columns
:::: column

> -- Fixed-precision integer
> i :: Int
> i = 12

Guaranteed[^haskell2010-int] to be at least $[ - 2^{29}, 2^{29} - 1]$,
but usually is machine word sized

> -- Actual bounds
> minInt, maxInt :: Int
> minInt = minBound
> maxInt = maxBound

[^haskell2010-int]: See [Haskell 2010 Language Report, Section 6.4 Numbers](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1350006.4)

::::
:::: column

. . .

> -- Arbitrary-precision integer
> n :: Integer
> n = 2 ^ (2 ^ (2 ^ (2 ^ 2)))
>
> numDigits :: Int
> numDigits = length (show n)
>
> -- >>> numDigits
> -- 19729

::::
:::

```{=latex}
\end{onlyenv}
```

. . .

```{=latex}
\begin{onlyenv}<.-.(2)>
```

::: columns
:::: column

> -- Double-precision floatint point
> d1, d2 :: Double
> d1 = 3.1415
> d2 = 6.2831e-4

> -- Boolean
> b1, b2 :: Bool
> b1 = True
> b2 = False

::::
:::: column

. . .

```{=latex}
\lstset{
  style=default,
  literate=
    {^1}{{\emoji{earth-americas}}}2
    {^2}{$\lambda$}1
}
```

```haskell
-- Unicode code point (character)
c1, c2, c3 :: Char
c1 = 'A'
c2 = '^2'
c3 = '^1'

-- String (list of characters)
s :: String
s = "Hello world! ^1"
```

\ignore{ % Have to ignore this to properly display unicode on slides

> -- Unicode code point (character)
> c1, c2, c3 :: Char
> c1 = 'A'
> c2 = 'λ'
> c3 = '🌎'

> -- String (list of characters)
> s :: String
> s = "Hello world! 🌎"

}

::::
:::

```{=latex}
\end{onlyenv}
```

:::::

```{=latex}
\end{minipage}
```

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
