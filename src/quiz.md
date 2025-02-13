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
(++) [True]

zip [0..] "Test"

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

{.plain}
==========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```
