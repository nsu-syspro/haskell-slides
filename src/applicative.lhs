---
title: Applicative
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Applicative(..))
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering


```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia-functor.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-applicative.pdf){width=100%}

```{=latex}
}
```

Applicative functor {.fragile}
===================

::: columns
:::: {.column width=50%}

Can we implement this function? \centering
-------------------------------

. . .

```haskell
fmap2 :: Functor f => (a -> b -> c)
                   -> f a -> f b -> f c
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
fmap2 g fa fb = _ (fmap g fa) fb
```

. . .

```haskell
-- Have: (fmap g fa) :: f (b -> c)
-- Want: \_ :: f (b -> c) -> f b -> f c
```

. . .

We can't! `Functor` is too weak \centering
-------------------------------

::::
:::: {.column width=50%}

. . .

[Data.Applicative](https://hackage.haskell.org/package/base/docs/Data-Applicative.html) \centering
------------------

. . .

> class Functor f => Applicative f where
>   pure   :: a -> f a
>   (<*>)  :: f (a -> b) -> f a -> f b
>   liftA2 :: (a -> b -> c)
>          -> f a -> f b -> f c
>   (*>)   :: f a -> f b -> f b
>   (<*)   :: f a -> f b -> f a

. . .

Minimal complete definition \centering
---------------------------

\centering

`pure`, (`(<*>)` | `liftA2`)

::::
:::

Intuition {.fragile}
=========

```{=latex}
\lstset{style=highlight}
```

::: columns
:::: {.column width=50%}

. . .

Container \centering
---------

. . .

:::::: incremental

- `fmap :: (a -> b) -> f a -> f b`  
  applies function to each element
  inside of container

- `pure :: a -> f a`  
  creates singleton container

- `(<*>) :: f (a -> b) -> f a -> f b`  
  applies container of functions
  to container of values

- `Maybe a` container with 0 or 1 elements

- `[a]` list of arbitrary length

::::::

::::
:::: {.column width=50%}

. . .

Computation context \centering
-------------------

. . .

:::::: incremental

- `fmap :: (a -> b) -> f a -> f b`  
  applies function to value *in context*
  without changing the context

- `pure :: a -> f a`  
  wraps value into *effect-free* context

- `(<*>) :: f (a -> b) -> f a -> f b`  
  applies function *in context* to value *in context*
  *combining* results of computations

- `Maybe a` computation with failure

- `[a]` non-deterministic computation

- `Either e a` computation with error

- `(e, a)` writer, computation with output

- `e -> a` reader, computation with input

- `IO a` computation with side-effects

::::::

::::
:::

Applicative laws {.fragile}
================

::: columns
:::: {.column width=52%}

. . .

Identity \centering
--------

```{.haskell style=small}
pure id <*> v = v
```

. . .

\vspace{-1em}

Homomorphism \centering
------------

```{.haskell style=small}
pure f <*> pure x = pure (f x)
```

. . .

\vspace{-1em}

Interchange \centering
-----------

```{.haskell style=small}
u <*> pure y = pure (\f -> f y) <*> u
```

. . .

\vspace{-1em}

Composition \centering
-----------

```{.haskell style=small}
u <*> (v <*> w) = pure (.) <*> u <*> v <*> w
```

. . .

\vspace{-1em}

Functor \centering
-------

```{.haskell style=small}
fmap f x = pure f <*> x
```

::::
:::: {.column width=48%}

. . .

Intuition \centering
---------

. . .

Laws describe normalization algorithm
that transforms chain of effectful applications
  
```{.haskell style=small}
            a1  <*> a2  <*> ... <*> an
```

into following form

```{.haskell style=small}
 pure f <*> a1' <*> a2' <*> ... <*> an'
```

where all `ai'`{style=highlight} perform effectful computation,
and all effect-free computations are
combined into single `pure f`{style=highlight} in the beginning

. . .

As well as ensure that `pure`{style=highlight} deserves its name

::::
:::

Resources {.fragile}
=========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Applicative}
\vspace{1em}
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Applicative>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://en.wikibooks.org/wiki/Haskell/Applicative_functors}
\vspace{1em}
```
<https://en.wikibooks.org/wiki/Haskell/Applicative_functors>
```{=latex}
\phantom{lp}
\end{minipage}
```

::::
:::

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = return ()

}
