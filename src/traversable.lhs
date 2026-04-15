---
title: Traversable
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Traversable(..))
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering


```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia-monad.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-traversable.pdf){width=100%}

```{=latex}
}
```

Traversable {.fragile}
===========

::: columns
:::: {.column width=52%}

[Data.Traversable](https://hackage.haskell.org/package/base/docs/Data-Traversable.html) \centering
------------------

. . .

> class (Functor t, Foldable t)
>    => Traversable t where
>   traverse  :: Applicative f
>             => (a -> f b) -> t a -> f (t b)
>   sequenceA :: Applicative f
>             => t (f a) -> f (t a)

. . .

\vspace{-1.3em}

>   mapM      :: Monad m
>             => (a -> m b) -> t a -> m (t b)
>   sequence  :: Monad m
>             => t (m a) -> m (t a)

. . .

Minimal complete definition \centering
---------------------------

\centering

(`traverse` | `sequenceA`)

::::
:::: {.column width=48%}

. . .

Intuition \centering
---------

```{=latex}
\lstset{style=highlight}
```

. . .

- Generalization of `Functor` and `Foldable`

. . .

- `Traversable` *preserves* structure of `t`

. . .

- `sequenceA` applies all computations and combines results into *the same* structure

. . .

- `sequenceA` essentially *commutes* two functors

. . .

- `traverse` generalizes effectful `fmap`

. . .

- `traverse` maps each element to applicative computation and then
  combines them with `sequenceA`

::::
:::


Applicative laws {.fragile}
================

::: columns
:::: {.column width=51%}

. . .

Identity \centering
--------

```haskell
traverse Identity = Identity
```

. . .

Composition \centering
------------

```haskell
traverse (Compose . fmap g . f) =
Compose . fmap (traverse g) . traverse f
```

. . .

Naturality \centering
-----------

```haskell
t . traverse f = traverse (t . f)
```

. . .

\footnotesize \centering

In Haskell this law can be derived from other two due to parametricity!

::::
:::: {.column width=49%}

. . .

[Data.Functor.Identity](https://hackage.haskell.org/package/base/docs/Data-Functor-Identity.html) \centering
------------------

. . .

```haskell
newtype Identity a =
          Identity { runIdentity :: a }
```

\vspace{-1em}

. . .

[Data.Functor.Const](https://hackage.haskell.org/package/base/docs/Data-Functor-Const.html) \centering
------------------

. . .

```haskell
newtype Const a b  =
             Const { getConst :: a }
```

\vspace{-1em}

. . .

Signatures \centering
----------

. . .

- `Applicative u, Applicative w`

. . .

- `f :: a -> u b`

. . .

- `g :: b -> w c`

. . .

- `t :: u b -> w b`  
  Applicative morphism from functor `u` to `w`

::::
:::


Resources {.fragile}
=========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Traversable}
\vspace{1em}
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Traversable>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://hackage-content.haskell.org/package/base/docs/Data-Traversable.html}
\vspace{1em}
```
<https://hackage-content.haskell.org/package/base/docs/Data-Traversable.html>
```{=latex}
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
