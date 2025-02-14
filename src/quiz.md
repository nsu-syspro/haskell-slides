---
title: Quiz
---

Quiz 1 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=50%}

Evaluate expression \centering
-------------------

```haskell
succ (2 - pred 1)

drop 2 (take 4 "Haskell") > map succ "cat"

sum (map fromEnum (enumFrom False))

map (\x -> x * 2) [1,3..10] ++ [100,1000]
```

::::
\hfill
\vrule
\hfill
:::: {.column width=46%}

Guess type signature \centering
--------------------

```haskell
max "Haskell"

map fst

map (take 2)
```

::::
:::

Quiz 2 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=50%}

Guess type signature \centering
-------------------

```haskell
(++) [True]

zip [0..]

map filter
```

::::
\hfill
\vrule
\hfill
:::: {.column width=46%}

Guess type signature \centering
--------------------

```haskell
alph = 'a' : alph

foo = zipWith (:)

f = f f

y g = g (y g)
```

::::
:::

Quiz 3 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=50%}

Guess type signature \centering
-------------------

```haskell
z x y = zip x (concat y)

concatMap f x = concat (map f x)

f = 0 : 1 : zipWith (+) f (tail f)
```

::::
\hfill
\vrule
\hfill
:::: {.column width=46%}

Guess the function(s) \centering
---------------------

```haskell
_ :: a -> a

_ :: a -> b

_ :: a -> [a] -> [a]

_ :: [a] -> Maybe (a, [a])
```

::::
:::

{.plain}
==========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```
