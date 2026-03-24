---
title: Functor
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Functor(..), ($>), (<$>), (<&>))

> infixl 4 <$
> infixl 4 $>
> infixl 4 <$>
> infixl 1 <&>
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering


```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia-foldable.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-functor.pdf){width=100%}

```{=latex}
}
```

Functor {.fragile}
========

[Data.Functor](https://hackage.haskell.org/package/base/docs/Data-Functor.html) \centering
--------------

. . .

::: columns
:::: {.column width=45%}

> class Functor f where
>   fmap :: (a -> b) -> f a -> f b
>   (<$) :: a -> f b -> f a

. . .

Minimal complete definition \centering
---------------------------

\centering

`fmap`

::::
:::: {.column width=55%}

. . .

> (<$>) :: Functor f => (a -> b) -> f a -> f b

. . .

```{=latex}
\vspace{-1.3em}
```

> (<$>) = fmap

. . .

> (<&>) :: Functor f => f a -> (a -> b) -> f b

. . .

```{=latex}
\vspace{-1.3em}
```

> (<&>) = flip fmap

. . .

> ($>)  :: Functor f => f a -> b -> f b 
> ($>)  = flip (<$)

::::
:::

Examples {.fragile}
========

. . .

::: columns
:::: {.column width=46%}

> instance Functor [] where
>   fmap f [] = []
>   fmap f (x : xs) = f x : fmap f xs

. . .

> instance Functor Maybe where
>   fmap f Nothing = Nothing
>   fmap f (Just v) = Just (f v)

. . .
 
> instance Functor (Either e) where
>   fmap f (Left e)  = Left e
>   fmap f (Right x) = Right (f x)

::::
:::: {.column width=54%}

. . .

```haskell
{-# LANGUAGE DeriveFunctor #-}
data Tree a = Empty
            | Leaf a
            | Branch (Tree a) a (Tree a)
  deriving Functor
```

```{=latex}
\vspace{-0.5em}
```

`\onslide<.(4)->`{=latex}Writer monad \centering
------------

. . .
 
> instance Functor ((,) e) where

. . .

```{=latex}
\vspace{-1.3em}
```

>   fmap f (x, y) = (x, f y)

```{=latex}
\vspace{-1em}
```

. . .

`\onslide<.(5)->`{=latex}Reader monad \centering
------------

. . .

> instance Functor ((->) e) where

. . .

```{=latex}
\vspace{-1.3em}
```

>   fmap :: (a -> b) -> (e -> a) -> (e -> b)

. . .

```{=latex}
\vspace{-1.3em}
```

>   fmap = (.)

::::
:::

Contravariant {.fragile}
=============

::: columns
:::: {.column width=50%}

Can this be made into `Functor`? \centering
--------------------------------

. . .

> newtype B r a = B (a -> r)

. . .

```haskell
instance Functor (B r) where
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
  fmap :: (a -> b) -> B r a -> B r b
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
  fmap f (B g) = B (_)
```

. . .

```haskell
-- Have: f \ :: a -> b
-- \ \ \ \ \ \ g \ :: a -> r
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
-- Want: \_ \ :: b -> r
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
-- Need: f' :: b -> a
```

. . .

::::
:::: {.column width=50%}

. . .

[Data.Functor.Contravariant](https://hackage.haskell.org/package/base/docs/Data-Functor-Contravariant.html) \centering
----------------------------

> class Contravariant f where
>   contramap :: (b -> a) -> f a -> f b
>   (>$) :: b -> f b -> f a

. . .

```{=latex}
\vspace{-0.5em}
```

Minimal complete definition \centering
---------------------------

\centering

`contramap`

. . .

> instance Contravariant (B r) where

. . .

```{=latex}
\vspace{-1.3em}
```

>   contramap :: (b -> a) -> B r a -> B r b

. . .

```{=latex}
\vspace{-1.3em}
```

>   contramap f (B g) = B (g . f)

. . .

::::
:::

::: columns
:::: {.column width=50%}

```{=latex}
\onslide<9->
```

Can't be `Functor`! \centering
-------------------

::::
:::: {.column width=50%}

```{=latex}
\onslide<.(1)->
```

Can be `Contravariant`! \centering
-------------------------

::::
:::

Continuation {.fragile}
============

::: columns
:::: {.column width=50%}

Can this be made into `Functor`? \centering
--------------------------------

. . .

> newtype C r a = C ((a -> r) -> r)

. . .

> instance Functor (C r) where

. . .

```{=latex}
\vspace{-1.3em}
```

>  fmap :: (a -> b) -> C r a -> C r b

. . .

```{=latex}
\vspace{-1.3em}
\vspace{-1.3em}
\begin{overprint}
\onslide<.(1)-.(3)>
```

```haskell
 fmap f (C g) = C (\h -> _)
```

```{=latex}
\onslide<.(4)->
```

>  fmap f (C g) = C (\h -> g (h . f))

```{=latex}
\end{overprint}
```

. . .

```haskell
-- Have: f \ :: a -> b
-- \ \ \ \ \ \ g \ :: (a -> r) -> r
-- \ \ \ \ \ \ h \ :: b -> r
```

. . .

```{=latex}
\vspace{-1.3em}
```

```haskell
-- Want: \_ \ :: r
```

. . .

. . .

```{=latex}
\vspace{-1.3em}
```

Can be `Functor`! \centering
-----------------

::::
:::: {.column width=50%}

. . .

[Control.Monad.Cont](https://hackage.haskell.org/package/mtl/docs/Control-Monad-Cont.html#t:Cont) \centering
--------------------

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://hackage.haskell.org/package/mtl/docs/Control-Monad-Cont.html#t:Cont}
\vspace{1em}
```
<https://hackage.haskell.org/package/mtl/docs/Control-Monad-Cont.html#t:Cont>
```{=latex}
\end{minipage}
```

::::
:::

Laws {.fragile}
====

::: columns
:::: {.column width=60%}

. . .

Functor laws \centering
------------

```{.haskell style=small}
    (1) fmap id = id
    (2) fmap f . fmap g = fmap (f . g)
```

. . .

\footnotesize \centering

In Haskell `(2)` can be derived from `(1)` due to parametricity!

. . .

```{=latex}
\onslide<7->
```

Free theorem \centering
-------------

\vspace{1em}

```{=latex}
\onslide<8->
```

`f :: [a] -> [a]`{.haskell} \centering

```{.haskell style=small}
    forall g :: a -> b
      map g . f = f . map g
```

\vspace{1em}

```{=latex}
\onslide<10->
```

`(free)` $\qquad$`fmap :: (a -> b) -> [a] -> [b]`{.haskell} \centering

```{.haskell style=small}
    forall fmap' :: (a -> b) -> t a -> t b
      if   a . b = c . d
      then fmap a . fmap' b = fmap' c . fmap d
```

::::
:::: {.column width=40%}

\vspace{-1em}

```{=latex}
\begin{overlayarea}{\linewidth}{\textheight}
```

```{=latex}
\begin{onlyenv}<4-10>
\onslide<4-10>
```

::::: block

Parametricity \centering
-------------

\centering

```{=latex}
\onslide<5-10>
```

Consider generic function

```{.haskell style=small}
           f :: [a] -> [a]
```

```{=latex}
\onslide<6-10>
```

Representatives

```{.haskell style=small}
    id       :: [a] -> [a]
    const [] :: [a] -> [a]
    drop 2   :: [a] -> [a]
    take 2   :: [a] -> [a]
    reverse  :: [a] -> [a]
```

```{=latex}
\onslide<9-10>
```

Example

```{.haskell style=small}
              f = reverse
map g . reverse = reverse . map g
```

:::::

```{=latex}
\end{onlyenv}
\begin{onlyenv}<11-14>
```

::::: block

Proof: `(2)` can be derived from `(1)` \centering
--------------------------------------

\centering

```{=latex}
\begin{onlyenv}<12->
```

Suppose law `(1)` holds for `fmap`:
  
```{.haskell style=small}
(1) fmap id = id
```

```{=latex}
\end{onlyenv}
\begin{onlyenv}<13->
```

Then using `(free)` and 

```{.haskell style=small}
    fmap' = fmap, a = f,  b = g
    c = id, d = (f . g)
```

We get

```{.haskell style=small}
    fmap f . fmap g
  = fmap id . fmap (f .g) -- (free)
  = id . fmap (f . g)     -- (1)
  = fmap (f . g)
```

```{=latex}
\end{onlyenv}
\begin{onlyenv}<14>
```

```{.haskell style=small}
(2) fmap f . fmap g = fmap (f . g)
```

\hfill $\qed$

```{=latex}
\end{onlyenv}
```

:::::

```{=latex}
\end{onlyenv}
\begin{onlyenv}<15-19>
```

::::: block

Uniqueness \centering
----------

\centering

```{=latex}
\begin{onlyenv}<16-19>
\footnotesize
```

If `fmap`{.haskell} satisfies `(1)` (and `(2)`) then it is unique

```{=latex}
\begin{uncoverenv}<17-19>
```

\vspace{1em}
\normalsize

Each function `fmap' :: (a -> b) -> f a -> f b`{.haskell}
satisfying `(1)` (and `(2)`) is equivalent to `fmap`:

`fmap' ~ fmap`{.haskell}

```{=latex}
\end{uncoverenv}
\end{onlyenv}
```

:::::

```{=latex}
\begin{onlyenv}<18-19>
```

::::: block

Proof \centering
-----

```{=latex}
\begin{onlyenv}<19>
```

\small

Suppose there is `fmap' != fmap`{.haskell} that satisfies `(1)`

```{.haskell style=small}
    fmap' id
  = id        -- (1) fmap'
  = fmap id   -- (1) fmap
```

\hfill $\qed$

```{=latex}
\end{onlyenv}
```

:::::

```{=latex}
\end{onlyenv}
\end{onlyenv}
\begin{onlyenv}<20->
```

::::: block

Examples of unlawful functors \centering
-----------------------------

\centering

```{=latex}
\begin{onlyenv}<21-22>
```

Breaks both laws

```{.haskell style=small}
instance Functor [] where
  fmap f [] = []
  fmap f (x : xs) = f x : f x
                        : fmap f xs
```

```{=latex}
\end{onlyenv}
\begin{onlyenv}<22>
```

Breaks `(1)`, but not `(2)`

```{.haskell style=small}
instance Functor Maybe where
  fmap f _ = Nothing
```

```{=latex}
\end{onlyenv}
\begin{onlyenv}<23->
```

Breaks `(2)`, but not `(1)`

\vspace{1em}

\footnotesize \centering
We need "bottom" (`undefined`{.haskell}, `error`{.haskell} etc)

```{=latex}
\begin{minipage}[c][.6\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://github.com/quchen/articles/blob/master/second_functor_law.md#bottom-ruins-the-party}
\vspace{1em}
```
<https://github.com/quchen/articles/blob/master/second_functor_law.md#bottom-ruins-the-party>
```{=latex}
\end{minipage}
```

```{=latex}
\end{onlyenv}
```

:::::

```{=latex}
\end{onlyenv}
```

```{=latex}
\end{overlayarea}
```

::::
:::

Resources {.fragile}
=========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Functor}
\vspace{1em}
\small
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Functor>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://en.wikibooks.org/wiki/Haskell/Category_theory}
\vspace{1em}
\small
```
<https://en.wikibooks.org/wiki/Haskell/Category_theory>
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

> main = pure ()

}
