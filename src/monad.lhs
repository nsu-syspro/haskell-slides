---
title: Monad
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Monad(..))
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering


```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia-alternative.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-monad.pdf){width=100%}

```{=latex}
}
```

Monad {.fragile}
=====

::: columns
:::: {.column width=50%}

Can we implement this function? \centering
-------------------------------

. . .

:::::: incremental

- Prompts user for name
- Reads the name from stdin
- Prints personalized greeting

::::::

. . .

```haskell
greet :: IO ()
greet = 
     putStr "Enter your name: "
  *> getLine
  *> putStrLn ("Hello " ++ _)
```

. . .

\vspace{-1.3em}

```haskell
  -- Need to use result of getLine
  -- in last putStrLn
```

We can't! `Applicative` is too weak! \centering
--------------------------------


::::
:::: {.column width=50%}

. . .

[Control.Monad](https://hackage.haskell.org/package/base/docs/Control-Monad.html) \centering
---------------

. . .

> class Applicative m => Monad m where
>   (>>=)  :: m a -> (a -> m b) -> m a

. . .

```{=latex}
\vspace{-1.3em}
```

>   (>>)   :: m a -> m b -> m b
>   return :: a -> m a

. . .

\vspace{-1.3em}

Minimal complete definition \centering
---------------------------

\centering

`(>>=)`

. . .

\vspace{-0.5em}

Many ways to compose functions \centering
------------------------------

. . .

```haskell
   ($)   ::   (a ->   b) ->   a ->   b
   fmap  ::   (a ->   b) -> f a -> f b
   (<*>) :: f (a ->   b) -> f a -> f b
   (=<<) ::   (a -> m b) -> m a -> m b
```

::::
:::

Equivalent definitions {.fragile}
======================

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=54%}

. . .

Bind \centering
----

```haskell
(>>=) :: m a -> (a -> m b) -> m b
```

. . .

Join \centering
----

```
join  :: m (m a) -> m a
```

. . .

Kleisli composition \centering
-------------------

. . .

Functions with signature `_ :: (a -> m b)` are called Kleisli arrows

. . .

```
(>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)
```

. . .

\vspace{-1.3em}

```
(<=<) :: (b -> m c) -> (a -> m b) -> (a -> m c)
```

::::
:::: {.column width=46%}

. . .

Example \centering
-------

. . .

```haskell
readMaybe  :: String -> Maybe Int
safeDiv    :: Int    -> Maybe Double
```

. . .

```haskell
readDiv    :: String -> Maybe Double
```

. . .

\vspace{0.5em}

\hrule

. . .

```
readDiv s = readMaybe s >>= safeDiv
```

. . .

```
readDiv = join . fmap safeDiv . readMaybe
```

. . .

```
readDiv = readMaybe >=> safeDiv
```

. . .

```
readDiv = safeDiv <=< readMaybe
```

::::
:::

Monad laws {.fragile}
==========

```{=latex}
\lstset{style=small}
```

::: columns
:::: {.column width=52%}

. . .

Bind laws\phantom{p} \centering
---------

- Left identity  
  `return a >>= k = k a`
- Right identity  
  `m >>= return = m`
- Associativity  
  `m >>= (\x -> k x >>= h) = (m >>= k) >>= h`

::::
:::: {.column width=48%}

. . .

Kleisli composition laws \centering
------------------------

- Left identity  
  `return >=> g = g`
- Right identity  
  `g >=> return = g`
- Associativity  
  `(g >=> h) >=> k = g >=> (h >=> k)`

::::
:::

\vspace{2em}

::: columns
:::: {.column width=25%}

::::
:::: {.column width=50%}

. . .

Join laws \centering
---------

- `join . fmap join = join . join`
- `join . fmap return = join . return = id`
- `return . f = fmap f . return`
- `join . fmap (fmap f) = fmap f . join`

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
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Monad}
\vspace{1em}
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Monad>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://en.wikibooks.org/wiki/Haskell/Category_theory#Monads}
\vspace{1em}
```
<https://en.wikibooks.org/wiki/Haskell/Category_theory#Monads>
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
