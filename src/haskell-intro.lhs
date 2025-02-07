---
title: Introduction to Haskell
subtitle: Functional programming in Haskell
---

What is Haskell?
================

::: columns
:::: {.column width=58%}

```{=latex}
\begin{minipage}[c][.5\textheight][c]{\linewidth}
\centering
```

- Pure, lazy and functional programming language
- Designed by a committee of researchers
- Haskell 1.0 Report released 1990
- [Haskell 98 Language Report](https://www.haskell.org/onlinereport/)
- [Haskell 2010 Language Report](https://www.haskell.org/onlinereport/haskell2010/)
  (*current standard*)
- Actively developed on top of standard via
  extensions to Glasgow Haskell Compiler (GHC)
- Most changes in GHC are accompanied by [research paper](https://wiki.haskell.org/index.php?title=Research_papers)
  - Compiler and language research platform
  - Production-ready compiler and runtime

```{=latex}
\end{minipage}
```

::::
:::: {.column width=42%}

```{=latex}
\begin{minipage}[c][.5\textheight][c]{\linewidth}
\centering
```
![](images/Haskell-Logo.pdf){width=80%}
```{=latex}
\end{minipage}
```

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

Note: any version 9.x.x or above will be fine

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
ghci> 2 + 3 * 2
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

Lists and tuples {.t}
================

::: columns
:::: {.column width=55%}

::::: block

Lists \centering
-----

- *Homogeneous* linked lists
  - `[]` --- empty list
  - `(:)` --- constructor "cons"
  - `(++)` --- concatenation
- Enumeration notation `[1..10]`

:::::

```{=latex}
\begin{uncoverenv}<2>
```

::::: block

\lstset{style=type}

Tuples \centering
------

- Cartesian product of several types
- Except for pairs should not be used anywhere`\only<2>{\footnote<2>{`{=latex}
  Haskell provides better ways via custom data structures
  `}}`{=latex}
  - `fst` and `snd` are only for pairs

:::::

```{=latex}
\end{uncoverenv}
```

::::
:::: {.column width=40%}

```{=latex}
\begin{onlyenv}<1>
```

```haskell {style=small}
ghci> [1,2,3]
[1,2,3]
ghci> []
[]
ghci> 1 : []
[1]
ghci> [3,4] ++ [1,2]
[3,4,1,2]
ghci> 1 : 2 : 3 : []
[1,2,3]
ghci> 1 : 2 : 3 : [] == [1,2,3]
True
ghci> [1..5]
[1,2,3,4,5]
ghci> [1,3..10]
[1,3,5,7,9]
```

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<2>
```

```haskell {style=small}
ghci> (1,2)
(1,2)
ghci> (True,2)
(True,2)
ghci> fst (True,2)
True
ghci> snd (True,2)
2
ghci> (True,[1,2],42)
(True,[1,2],42)
```

```{=latex}
\end{onlyenv}
```

::::
:::

Strings
=======

::: columns
:::: {.column width=55%}

Strings are lists \centering
-----------------

- Strings are lists of Unicode characters^[Actually
  [Unicode code points](https://hackage.haskell.org/package/base-4.21.0.0/docs/Data-Char.html)]
- Characters can be enumerated
- Strings can be compared lexicographically
- In real world more efficient implementations are used
  (see [text](https://hackage.haskell.org/package/text-2.1.2/docs/Data-Text.html)
  and [bytestring](https://hackage.haskell.org/package/bytestring-0.12.2.0/docs/Data-ByteString.html))

::::
:::: {.column width=40%}

```{=latex}
\lstset{
  style=default,
  literate=
    {^2}{$\lambda$}1 % 𝜆
}
```

```haskell {style=small}
ghci> 'a'
'a'
ghci> '^2'
'\120582'
ghci> putStrLn "^2"
^2
ghci> "abc123"
"abc123"
ghci> ['a','b','c']
"abc"
ghci> 'a' : "bc" == "abc"
True
ghci> ['a'..'f']
"abcdef"
ghci> "Haskell" > "C++"
True
```

::::
:::

More functions
==============

::: columns
:::: {.column width=48%}

List functions \centering\phantom{y}
--------------

```haskell {style=small}
ghci> length "Haskell"
7
ghci> reverse "Haskell"
"lleksaH"
ghci> take 2 "Hello" ++ drop 5 "Haskell"
"Hell"
ghci> filter even [1..10]
[2,4,6,8,10]
ghci> sum (filter even [1..10])
30
ghci> map odd [1..5]
[True,False,True,False,True]
```

. . .

::::
:::: {.column width=50%}

Anonymous functions^[Also known as *lambda functions*] \centering
-------------------

```haskell {style=small}
ghci> (\x -> 3 * x + 2) 2
8
ghci> map (\x -> 3 * x + 2) [1..5]
[5,8,11,14,17]
ghci> (\x y -> x + y) 2 3
5
ghci> zipWith (\x y -> x + y) [1..5] [6..10]
[7,9,11,13,15]
ghci> zipWith (+) [1..5] [6..10]
[7,9,11,13,15]
```

::::
:::

Types {.t}
=====

::: columns
:::: {.column width=48%}

Inspecting types in GHCi \centering
------------------------

```haskell {style=small}
ghci> :t 'a'
'a' :: Char
ghci> :t True
True :: Bool
ghci> :t [True,False]
[True,False] :: [Bool]
ghci> :t (True,'a')
(True,'a') :: (Bool, Char)
ghci> :t ('a',True)
('a',True) :: (Char, Bool)
ghci> :t not
not :: Bool -> Bool
```

- `::`{style=highlight} reads as "has type"

. . .

::::
:::: {.column width=48%}

Parametric polymorphism \centering
-----------------------

```haskell {style=small}
ghci> :t reverse
reverse :: [a] -> [a]
ghci> reverse [1,2,3]
[3,2,1]
ghci> reverse "Haskell"
"lleksaH"
ghci> :t fst
fst :: (a, b) -> a
```

- Lower-case identifiers in type signatures are *type variables*
- Concrete types always start with upper-case letter

::::
:::

Types {.t}
=====

::: columns
:::: {.column width=58%}

Currying \centering
--------

- Functions with multiple parameters are always *curried*[^curry]
  - Accept exactly one argument and return another function
- `->` is *right-associative*,
  so following type signatures are the same
  ```haskell {style=small}
  take :: Int -> [a] -> [a]
  take :: Int -> ([a] -> [a])
  ```
- Allows *partial application* of function to the first argument(s)

[^curry]: This idea was first introduced by *Moses Schönfinkel*
and then further developed and popularized by *Haskell Curry*

::::
:::: {.column width=41%}

```haskell {style=small}
ghci> :t take
take :: Int -> [a] -> [a]
ghci> :t take 2
take 2 :: [a] -> [a]
ghci> :t take 2 "abc"
take 2 "abc" :: [Char]
ghci> :t map
map :: (a -> b) -> [a] -> [b]
ghci> :t map (take 2)
map (take 2) :: [[a]] -> [[a]]
ghci> map (take 2) ["abc", "def"]
["ab","de"]
```

::::
:::

Types {.t}
=====

::: columns
:::: {.column width=58%}

Overloading \centering
-----------

- Type variables of polymorphic functions can have
  additional constraints[^type-classes] denoted by `=>`{style=type} clause
- In that case we say that they are *overloaded*
- Overloaded functions use some specific API provided by those constraints in their implementation
- `Ord`{.haskell} means something *comparable*
- `Num`{.haskell} is any number-like type (`Int`{.haskell}, `Integer`{.haskell}, `Double`{.haskell})
- `Foldable`{.haskell} is a generalization of any container-like type[^foldable]

[^type-classes]: Such constraints are called *type classes* and we will encounter them a lot during semester

[^foldable]: For now consider it to be simply list type

::::
:::: {.column width=41%}

```haskell {style=small}
ghci> :t max
max :: Ord a => a -> a -> a
ghci> max "Haskell" "C++"
"Haskell"
ghci> max 3 5
5
ghci> :t (>)
(>) :: Ord a => a -> a -> Bool
ghci> :t (+)
(+) :: Num a => a -> a -> a
ghci> :t length
length :: Foldable t => t a -> Int
```

::::
:::

Types {.t}
=====

::: columns
:::: {.column width=58%}

Built-in types \centering
--------------

- Numeric literals are overloaded
- We can explicitly specify type for any expression
- `Int`{.haskell} --- fixed-precision integer type
  - Guaranteed to be at least $[ - 2^{29}, 2^{29} - 1]$[^haskell2010-int],
    but usually is machine word sized
- `Integer`{.haskell} --- arbitrary-precision integer type
  - Implemented internally via GNU Multiple Precision Arithmetic Library (GMP)[^int-gmp]
- `Float`{.haskell} --- single-precision floating point type
- `Double`{.haskell} --- double-precision floating point type
- `Char`{.haskell} --- Unicode code point (character)
- `()` --- Unit type

[^haskell2010-int]: See [Haskell 2010 Language Report, Section 6.4 Numbers](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1350006.4)

[^int-gmp]: See [integer-gmp](https://hackage.haskell.org/package/integer-gmp) package

::::
:::: {.column width=41%}

```haskell {style=small}
ghci> :t 2
2 :: Num a => a
ghci> :t maxBound
maxBound :: Bounded a => a
ghci> maxBound
()
ghci> maxBound :: Int
9223372036854775807
ghci> maxBound :: Char
'\1114111'
ghci> 2^100
1267650600228229401496703205376
ghci> 2^100 :: Int
0
ghci> 2^100 :: Integer
1267650600228229401496703205376
```

::::
:::

Types {.t}
=====

::: columns
:::: {.column width=58%}

Explicit effects \centering
----------------

- All functions in Haskell are *pure* by default
- *Impure* functions explicitly marked with `IO`{.haskell} type
- `IO ()`{.haskell} represents action that does not yield any result
  but produces some *side effect*
- Side effects include
  - Interacting with `stdin`/`stdout`
  - Mutating global program state
  - Reading and writing files
  - Accessing database
  - Sending or receiving TCP/IP requests
- `Show`{.haskell} constraint provides conversion from given type
  to `String`{.haskell} via `show`{.haskell} function
- Under the hood GHCi uses `print`{.haskell} to show expressions on screen

::::
:::: {.column width=41%}

```haskell {style=small}
ghci> :t putStrLn
putStrLn :: String -> IO ()
ghci> putStrLn "Hello"
Hello
ghci> "Hello"
"Hello"
ghci> :t print
print :: Show a => a -> IO ()
ghci> print "Hello"
"Hello"
ghci> show "Hello"
"\"Hello\""
ghci> print [1,2,3]
[1,2,3]
ghci> show [1,2,3]
"[1,2,3]"
```

::::
:::

Program structure
=================

::: columns
:::: {.column width=50%}

Modules \centering
-------

- Haskell program consists of *modules*
- Each module corresponds to single `.hs` or `.lhs`
  ([literate Haskell](https://wiki.haskell.org/index.php?title=Literate_programming)) file
- Each module contains *declarations*:
  - Function declarations (*bindings*)
  - Type signatures
  - Fixity declarations (associativity and precedence of operators)
  - *Type declarations*
  - And many others...
- Order of declarations does not matter

::::
:::: {.column width=50%}

Prelude \centering
-------

- Prelude is an implicitly imported module containing standard function and type declarations
- Most of the functions we have seen so far come from Prelude module
- Very little is actually built into Haskell language itself

```{=latex}
\begin{minipage}[c][.4\textheight][c]{\linewidth}
\centering
\qrcode[height=1.5cm]{https://hackage.haskell.org/package/base-4.21.0.0/docs/Prelude.html}
\vspace{1em}
```
<https://hackage.haskell.org/package/base-4.21.0.0/docs/Prelude.html>
```{=latex}
\end{minipage}
```

::::
:::

Functions {.t}
=========

::: columns
:::: {.column width=48%}

Bindings \centering
--------


```{=latex}
\onslide<2->
```

- Type signature
  - Optional but recommended
  - Improves type error messages
- Zero or more arguments
  - Binding without arguments is *constant*

```{=latex}
\onslide<3->
```

- `if p then x else y`{.haskell}

```{=latex}
\onslide<4->
```

- Guards
  - `\onslide<5->`{=latex} `otherwise = True`{.haskell}

```{=latex}
\onslide<6->
```

- Recursion

```{=latex}
\onslide<7->
```

- Pattern matching
  - Literals
  - `\onslide<9->`{=latex} *Constructors*

```{=latex}
\onslide
```

::::
:::: {.column width=52%}

```{=latex}
\begin{minipage}[c][.8\textheight][t]{\linewidth}
\centering
```

:::::: block

Examples \centering
--------

```{=latex}
\begin{onlyenv}<2>
```

> e :: Double
> e = exp 1

> square :: Int -> Int
> square x = x * x

> squareSum :: Int -> Int -> Int
> squareSum x y = square (x + y)

> sumSquare :: Int -> Int -> Int
> sumSquare x y = square x + square y

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<3-5>
```

> max' :: Int -> Int -> Int
> max' x y = if x > y then x else y

```{=latex}
\begin{onlyenv}<4-5>
```

> max'' :: Int -> Int -> Int
> max'' x y
>   | x > y     = x
>   | otherwise = y

```{=latex}
\end{onlyenv}
```

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<6-7>
```

> fib :: Integer -> Integer
> fib n
>   | n == 0    = 0
>   | n == 1    = 1
>   | otherwise = fib (n - 1) + fib (n - 2)

```{=latex}
\begin{onlyenv}<7>
```

> fib' :: Integer -> Integer
> fib' 0 = 0
> fib' 1 = 1
> fib' n = fib' (n - 1) + fib' (n - 2)

```{=latex}
\end{onlyenv}
```

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<8-10>
```

> rating :: String -> Int
> rating "Haskell" = 10
> rating "Scala"   = 8
> rating "C"       = 6
> rating "C++"     = 2
> rating _         = 0

```{=latex}
\begin{onlyenv}<9-10>
```

> sumPair :: (Int, Int) -> Int
> sumPair (x, y) = x + y

```{=latex}
\begin{onlyenv}<10>
```

> isEmpty :: [a] -> Bool
> isEmpty []     = True
> isEmpty (x:xs) = False

```{=latex}
\end{onlyenv}
```

```{=latex}
\end{onlyenv}
```

```{=latex}
\end{onlyenv}
```

::::::

```{=latex}
\end{minipage}
```

::::
:::

Factorial {.t}
=========

$n! = 1 \cdot 2 \cdot ... \cdot n$ \centering
----------------------------------

. . .

::: columns
:::: {.column width=48%}

\vspace{1.5em}
$$
\begin{aligned}
\uncover<2->{
F_1(n) &= \begin{cases}
  1 & \text{$n = 0$} \\
  n \cdot F_1(n - 1) & \text{otherwise}
\end{cases} \\[2.5em]
}
\uncover<4->{
F_2(0) &= 1 \\
F_2(n) &= n \cdot F_2(n - 1) \\[2.5em]
}
\uncover<6->{
F_3(n) &= \prod_{x = 1..n} x
}
\end{aligned}
$$

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

```{=latex}
\begin{uncoverenv}<3->
```

> fact1 :: Integer -> Integer
> fact1 n
>   | n == 0    = 1
>   | otherwise = n * fact1 (n - 1)

```{=latex}
\end{uncoverenv}
```

```{=latex}
\begin{uncoverenv}<5->
```

> fact2 :: Integer -> Integer
> fact2 0 = 1
> fact2 n = n * fact2 (n - 1)

```{=latex}
\end{uncoverenv}
```

```{=latex}
\begin{uncoverenv}<7->
```

> fact3 :: Integer -> Integer
> fact3 n = product [1..n]

```{=latex}
\end{uncoverenv}
```

::::
:::

<!-- Keep only footnote without its mark -->
`\only<8->{\sbox0{\footnote<8->[frame]{`{=latex}
Checkout more factorials in ["The Evolution of a Haskell Programmer"](https://people.willamette.edu/~fruehr/haskell/evolution.html)
`}}}`{=latex}

Collatz sequence {.t}
================

. . .

::: columns
:::: {.column width=44%}

Collatz function \centering
----------------

$$
f(n) = \begin{cases}
  n / 2  & \text{if } n \equiv 0 {\pmod{2}} \\
  3n + 1 & \text{if } n \equiv 1 {\pmod{2}}
\end{cases}
$$

. . .

Collatz conjecture[^collatz] \centering
------------------

[^collatz]: Wikipedia: [Collatz conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture)

A sequence obtained by consecutive application of
$f$ to *any* positive number eventually reaches number 1.

$$
n, f(n), f(f(n)), ..., 1
$$

::::
\hfill
\vrule
\hfill
:::: {.column width=52%}

. . .

> collatz :: Integer -> Integer
> collatz n
>   | even n    = n `div` 2
>   | otherwise = 3 * n + 1

. . .

> collatzSeq :: Integer -> [Integer]
> collatzSeq 1 = [1]
> collatzSeq n = n : collatzSeq (collatz n)

::::
:::

Exercise {.t}
========

Sum consecutive pairs of elements in the list \centering
---------------------------------------------

. . .

> -- >>> sumPairwise []
> -- []
> -- >>> sumPairwise [1]
> -- [1]
> -- >>> sumPairwise [1,2]
> -- [3]
> -- >>> sumPairwise [1,2,3]
> -- [3,3]

. . .

> sumPairwise :: [Int] -> [Int]
> sumPairwise []       = []
> sumPairwise [x]      = [x]
> sumPairwise (x:y:xs) = (x + y) : sumPairwise xs

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
