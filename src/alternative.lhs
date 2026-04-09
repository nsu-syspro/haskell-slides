---
title: Alternative
subtitle: Functional abstractions
---

Functional abstractions {.fragile}
=======================

\ignore{

> {-# OPTIONS_GHC -Wno-missing-methods #-}
> import Prelude hiding (Alternative(..))
  
}

. . .

[Typeclassopedia](https://wiki.haskell.org/index.php?title=Typeclassopedia) \centering
-----------------

\centering


```{=latex}
\only<.(1)>{
```

![](images/typeclassopedia-applicative.pdf){width=100%}

```{=latex}
}
```

```{=latex}
\only<.(2)>{
```

![](images/typeclassopedia-alternative.pdf){width=100%}

```{=latex}
}
```

Alternative functor {.fragile}
===================

::: columns
:::: {.column width=54%}

[Control.Applicative (Alternative)](https://hackage.haskell.org/package/base/docs/Control-Applicative.html#t:Alternative) \centering
-----------------------------------

. . .

> class Applicative f => Alternative f where
>   empty :: f a
>   (<|>) :: f a -> f a -> f a

. . .

```{=latex}
\vspace{-1.3em}
```

>   some  :: f a -> f [a]
>   many  :: f a -> f [a]

. . .

\vspace{-1.3em}

Minimal complete definition \centering
---------------------------

\centering

`empty`, `(<|>)`

. . .

\vspace{-0.5em}

Intuition \centering
---------

```{=latex}
\lstset{style=highlight}
```

. . .

::::: incremental

- Computation that supports *failure* or *choice*
- `empty` is failure
- `(<|>)` is choice between alternatives
- `some` runs computation at least once until it fails
- `many` runs computation until it fails

:::::

::::
:::: {.column width=46%}

```{=latex}
\lstset{style=highlight}
```

. . .

Maybe \centering
-----

. . .

- `empty = Nothing`
- `(<|>)` returns first success

. . .

\vspace{-0.8em}

List \centering
----

. . .

- `empty = []`
- `(<|>) = (++)`

. . .

\vspace{-0.8em}

IO \centering
--

. . .

- `empty` throws I/O exception
- `x <|> y` runs `x` and if it throws I/O exception then runs `y`

. . .

\vspace{-0.8em}

Applicative parsers \centering
-------------------

```{=latex}
{\centering \footnotesize
```

[parsec](https://hackage.haskell.org/package/parsec),
[megaparsec](https://hackage.haskell.org/package/megaparsec) and
[attoparsec](https://hackage.haskell.org/package/attoparsec)

```{=latex}
}
```

. . .

- `empty` fails to parse
- `x <|> y` tries parsing with `x` and if it fails then tries `y`

::::
:::

Alternative laws {.fragile}
================

::: columns
:::: {.column width=50%}

. . .

Monoid laws \centering
-----------

```{.haskell}
   empty <|> x     = x
       x <|> empty = x
   (x <|> y) <|> z = x <|> (y <|> z)
```

. . .

`Maybe`{style=green}, `[]`{style=green}, `IO`{style=green}, `parsers`{style=green} \centering

. . .

Left zero \centering
---------

```{.haskell}
          empty <*> f = empty
```

. . .

`Maybe`{style=green}, `[]`{style=green}, `IO`{style=green}, `parsers`{style=green} \centering

. . .

Right zero \centering
----------

```{.haskell}
          f <*> empty = empty
```

. . .

`Maybe`{style=green}, `[]`{style=green}, `IO`{style=error}, `parsers`{style=green} \centering

::::
:::: {.column width=50%}

. . .

Left distribution \centering
-----------------

```{.haskell}
(a <|> b) <*> c = (a <*> c) <|> (b <*> c)
```

. . .

`Maybe`{style=green}, `[]`{style=green}, `IO`{style=error}, `parsers`{style=error} \centering

. . .

Right distribution \centering
------------------

```{.haskell}
a <*> (b <|> c) = (a <*> b) <|> (a <*> c)
```

. . .

`Maybe`{style=green}, `[]`{style=error}, `IO`{style=error}, `parsers`{style=peach} \centering

. . .

Left catch \centering
----------

```{.haskell}
        (pure a) <|> x = pure a
```

. . .

`Maybe`{style=green}, `[]`{style=error}, `IO`{style=green}, `parsers`{style=green} \centering

::::
:::

Resources {.fragile}
=========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://wiki.haskell.org/index.php?title=Typeclassopedia#Failure_and_choice:_Alternative,_MonadPlus,_ArrowPlus}
\vspace{1em}
```
<https://wiki.haskell.org/index.php?title=Typeclassopedia#Failure_and_choice:_Alternative,_MonadPlus,_ArrowPlus>
```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.7\textheight][c]{\linewidth}
\centering
\qrcode[height=3.5cm]{https://en.wikibooks.org/wiki/Haskell/Alternative_and_MonadPlus}
\vspace{1em}
```
<https://en.wikibooks.org/wiki/Haskell/Alternative_and_MonadPlus>
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
