---
title: Quiz
---

Quiz 1 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

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
:::: {.column width=48%}

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
:::: {.column width=48%}

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
:::: {.column width=48%}

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
:::: {.column width=48%}

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
:::: {.column width=48%}

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

Quiz 4 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess the function(s) \centering
---------------------

```haskell
_ :: a -> b -> a

_ :: (a -> b -> c) -> b -> a -> c

_ :: ((a, b) -> c) -> a -> b -> c

_ :: (a -> b -> c) -> (a, b) -> c
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess the function(s) \centering
---------------------

```haskell
_ :: (a -> b) -> a -> b

_ :: (b -> c) -> (a -> b) -> a -> c

_ :: (b -> a -> b) -> b -> [a] -> b

_ :: (a -> b -> b) -> b -> [a] -> b
```

::::
:::

Quiz 5 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Evaluate expression \centering
-------------------

```haskell
(2^) . (3+) $ 4

map ($2) [(*2), (^3), (1+)]

(++ "!") . reverse $ "abc"
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess type signature \centering
--------------------

```haskell
flip const

const undefined

foldr (:) []

((filter even .) .)
```

::::
:::

Quiz 6 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess type signature \centering
--------------------

```haskell
filter (const True)

foldl' (flip (:)) []

map (,)
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

How many distinguishable *total* functions? \centering
-------------------------------------------

```haskell
_ :: a -> a

_ :: (a, a) -> (a, a)

_ :: a -> a -> Bool

_ :: Eq a => a -> a -> Bool
```

::::
:::

Quiz 7 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

How many distinguishable *total* functions? \centering
-------------------------------------------

```haskell
_ :: a -> b -> a

_ :: a -> a -> a

_ :: (b -> c) -> (a -> b) -> (a -> c)
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

How many distinguishable *total* functions? \centering
-------------------------------------------

```haskell
_ :: a -> Maybe a

_ :: a -> Maybe b

_ :: (a -> Maybe b) -> [a] -> [b]
```

::::
:::

Quiz 8 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

How many distinguishable *total* functions? \centering
-------------------------------------------

```haskell
_ :: Bool -> Bool -> Bool

_ :: Bool -> a -> a

_ :: [a] -> a
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess the function(s) \centering
---------------------

```haskell
_ :: (a -> a -> Bool) -> [a] -> [[a]]

_ :: (a -> a -> Ordering) -> [a] -> [a]

_ :: Ord a => (b -> a) -> b -> b -> Ordering
```

::::
:::

Quiz 9 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Evaluate expression \centering
-------------------

```haskell
foldr (++) "S" ["foo", "bar"]

foldl (++) "S" ["foo", "bar"]

foldr ($) "S" [(++ "foo"), (++ "bar")]

mconcat [(++ "foo"), (++ "bar")] "S"
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess the Semigroup(s) \centering
-------------------

```haskell
instance Semigroup (Maybe a) where
  (<>) :: Maybe a -> Maybe a -> Maybe a

newtype X a = X a
instance Semigroup a => Semigroup (X a) where
  (<>) :: X a -> X a -> X a

newtype Y a = Y a
instance Semigroup (Y a) where
  (<>) :: Y a -> Y a -> Y a
```

::::
:::

Quiz 10 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess the kind \centering
--------------

```haskell
data A a b = A a b

data B a b = B (a b)

data C a b = C (b (a b))

data D a b = D (a (b a))
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess `foldMap`{style=default} Monoid \centering
-------------------------------------

```haskell
product :: (Foldable t, Num a) =>
                           t a -> a

any :: Foldable t =>
            (a -> Bool) -> t a -> Bool

elem :: (Foldable t, Eq a) =>
                      a -> t a -> Bool
```

::::
:::

Quiz 11 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess `foldMap`{style=default} Monoid \centering
-------------------------------------

```haskell
find :: Foldable t =>
             (a -> Bool) -> t a -> Maybe a

safeMaximum :: (Foldable t, Ord a) =>
                            t a -> Maybe a

safeMaximumBy :: Foldable t =>
    (a -> a -> Ordering) -> t a -> Maybe a
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess type signature \centering
--------------------

```haskell
map (Just .) [even, odd]

map (const) [even, odd]

map (const .) [even, odd]
```

::::
:::

Quiz 12 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess the function(s) \centering
---------------------

```haskell
_ :: Foldable t => (a -> [b]) -> t a -> [b]

_ :: Foldable t => t Bool -> Bool

_ :: Foldable t => (a -> Bool) -> t a -> [a]
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess type signature \centering
-------------------

```haskell
foldMap . foldMap

foldMap . (flip foldMap)

foldMap . map
```

::::
:::

Quiz 13 {.t}
======

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=48%}

Guess type signature \centering
-------------------

```haskell
liftA2 (==)

liftA2 (take)

liftA2 (.)
```

::::
\hfill
\vrule
\hfill
:::: {.column width=48%}

Guess type signature \centering
-------------------

```haskell
liftA2 ($)

liftA2 (fmap)

liftA2 (liftA2)
```

::::
:::

{.plain}
==========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```
