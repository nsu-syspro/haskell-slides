---
title: Foldable
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Foldable(..))
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering

```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-monoid.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(3)>{
```

![](images/typeclassopedia-foldable.pdf){width=100%}

```{=latex}
}
```



Foldable {.fragile}
========

[Data.Foldable](https://hackage.haskell.org/package/base-4.22.0.0/docs/Data-Foldable.html) \centering
----------------

. . .

::: columns
:::: {.column width=55%}

> class Foldable t where
>  fold     :: Monoid m => t m -> m
>  foldMap  :: Monoid m => (a -> m) -> t a -> m
>  foldMap' :: Monoid m => (a -> m) -> t a -> m
>  foldr    :: (a -> b -> b) -> b -> t a -> b
>  foldr'   :: (a -> b -> b) -> b -> t a -> b
>  foldl    :: (b -> a -> b) -> b -> t a -> b
>  foldl'   :: (b -> a -> b) -> b -> t a -> b
>  foldr1   :: (a -> a -> a) -> t a -> a
>  foldl1   :: (a -> a -> a) -> t a -> a

. . .

::::
:::: {.column width=43%}

>  toList  :: t a -> [a]
>  null    :: t a -> Bool
>  length  :: t a -> Int
>  elem    :: Eq a => a -> t a -> Bool
>  maximum :: Ord a => t a -> a
>  minimum :: Ord a => t a -> a
>  sum     :: Num a => t a -> a
>  product :: Num a => t a -> a

::::
:::

. . .

Minimal complete definition \centering
---------------------------

\centering

`foldMap` | `foldr`

Examples {.fragile}
========

. . .

::: columns
:::: {.column width=50%}

> instance Foldable [] where
>   foldMap f = mconcat . map f

. . .

> instance Foldable Maybe where
>   foldMap f Nothing  = mempty
>   foldMap f (Just v) = f v

::::
:::: {.column width=50%}

. . .

> instance Foldable ((,) a) where
>   foldMap f (_, r) = f r

. . .

> instance Foldable (Either a) where
>   foldMap _ (Left a) = mempty
>   foldMap f (Right x) = f x

::::
:::

. . .

::: columns
:::: {.column width=25%}

::::
:::: {.column width=50%}

\centering
\vspace{1em}

```haskell
{-# LANGUAGE DeriveFoldable #-}
data Tree a = Empty
            | Leaf a
            | Branch (Tree a) a (Tree a)
  deriving Foldable
```

::::
:::: {.column width=25%}

::::
:::

Resources {.fragile}
=========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Data-Foldable.html#overview}
\vspace{1em}
```
<https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Data-Foldable.html#overview>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Foldable}
\vspace{1em}
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Foldable>
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

> main = pure ()

}
