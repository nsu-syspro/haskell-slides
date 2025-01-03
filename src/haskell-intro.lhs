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

Installing Haskell toolchain
============================

::: columns
:::: {.column width=55%}

Official installer [GHCup](https://www.haskell.org/ghcup/) \centering
----------------------------------------------------------

- GHC (Glasgow Haskell Compiler)
- GHCi --- interactive REPL-like environment
- HLS (Haskell Language Server) --- integration with [editors](https://haskell-language-server.readthedocs.io/en/latest/configuration.html#configuring-your-editor)
- `cabal` and `stack` --- tools for package management and development

```bash {style=small}
$ ghc --version
The Glorious Glasgow Haskell Compilation System,
version 9.4.8
```

Note: any version above 9.x.x will be fine

::::
:::: {.column width=45%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://www.haskell.org/ghcup/}
\vspace{1em}
```
<https://www.haskell.org/ghcup/>
```{=latex}
\end{minipage}
```

::::
:::

GHC interactive
===============

::: columns
:::: {.column width=50%}

Using GHCi \centering
----------

\lstset{style=highlight}

- `:?` --- help
- `:quit` or `:q` --- quit
- `:load` or `:l` --- load module
- `:reload` or `:r` --- reload modules
- `:info` or `:i` --- information about identifier
- `:type` or `:t` --- type of expression
- `:set` / `:unset` --- set or unset options

::::
:::: {.column width=48%}

```haskell {style=small}
$ ghci
GHCi, version 9.4.8:
https://www.haskell.org/ghc/ :? for help
ghci> 2
2
ghci> True
True
ghci> 'a'
'a'
ghci> "Hello"
"Hello"
ghci> [1,2,3]
[1,2,3]
ghci> (12, True)
(12, True)
ghic> :q
Leaving GHCi.
```

::::
:::

Evaluating expressions
======================

::: columns
:::: {.column width=33%}

Arithmetic \phantom{y}
----------

```haskell
ghci> 2 + 3
5
ghci> 2 + 3 * 2
8
ghci> (-2) * 4
-8
ghci> 5.0 / 2.0
2.5
ghci> 5 `div` 2
2
ghci> 5 `mod` 2
1
```

::::
:::: {.column width=33%}

Booleans and comparisons \phantom{y}
------------------------

```haskell
ghci> True && False
False
ghci> True || False
True
ghci> not True
False
ghci> 5 == 2 + 3
True
ghci> 5 /= 2 + 3
False
ghci> True > False
True
```

::::
:::: {.column width=33%}

Operators are functions \phantom{y}
-----------------------

```haskell
ghci> (+) 2 3
5
ghci> div 5 2
2
ghci> max 5 2
5
ghci> 5 `max` 2
5
```

::::
:::

Associativity and precedence {.t}
============================

::: columns
:::: {.column width=55%}

Symbolic operators
------------------

- Any non-alphanumeric identifier is considered operator and *infix* by default
- But can be made *prefix* by enclosing in parentheses
- Associativity and precedence must be explicitly specified

Alphanumeric functions
----------------------

- Any alphanumeric identifier is *prefix* by default
- But can be made *infix* by enclosing in backticks
- Function application has highest precedence and always left-associative

::::
:::: {.column width=40%}

```{=latex}
\begin{onlyenv}<1>
```

```haskell {style=small}
ghci> 2 + (3 * 2)
8
ghci> :i (+)
type Num :: * -> Constraint
class Num a where
  (+) :: a -> a -> a
  ...
  	-- Defined in `GHC.Num'
infixl 6 +
ghci> :i (*)
type Num :: * -> Constraint
class Num a where
  ...
  (*) :: a -> a -> a
  ...
  	-- Defined in `GHC.Num'
infixl 7 *
```

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<2>
```

```haskell {style=small}
ghci> max 2 3 + 2
4
ghci> (max 2 3) + 2
4
ghci> max 2 (3 + 2)
5
ghci> min 4 (max 2 3)
3
```

```{=latex}
\end{onlyenv}
```

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
>
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
