---
title: GHC internals by example
subtitle: Functional models of computation
---

GHC pipeline {.fragile}
============

\ignore{
  
}

```{=latex}
\vspace{.5em}
\begin{minipage}[c][.8\textheight][c]{\linewidth}
\centering
```

```{=latex}
\only<1>{
\centering
\includegraphics[height={.8\textheight}]{images/ghc-internals/hscpipe2.png}
}
\only<2->{
```

::: columns
:::: {.column width=50%}

```{=latex}
\centering
\includegraphics[height={.8\textheight},trim={0 26.4cm 0 0},clip]{images/ghc-internals/hscpipe2.png}
```

::::
:::: {.column width=50%}

```{=latex}
\centering
\includegraphics[height={.8\textheight},trim={0 0 0 24.7cm},clip]{images/ghc-internals/hscpipe2.png}
```

::::
:::

```{=latex}
}
\end{minipage}
```

```{=latex}
\onslide<1->
\begin{minipage}[c][.05\textheight][c]{\linewidth}
\centering
\footnotesize
```
<https://aosabook.org/en/v2/ghc.html#fig.ghc.pipeline>
```{=latex}
\end{minipage}
```

Core {.fragile}
====

::: columns
:::: {.column width=50%}

Core language \centering
-------------

- Tiny lazy functional language
  - variables, literals
  - let (means *allocation*)
  - case  (means *evaluation*)
  - lambda abstraction and application
- Variant of [System FC](https://www.microsoft.com/en-us/research/publication/system-f-with-type-equality-coercions/)

. . .

Compiler options \centering
----------------

`\lstset{style=default,basicstyle={\ttfamily\color{CtpPeach}}}`{=latex}

- `-ddump-ds` core *before* simplification
- `-ddump-simpl` core *after* simplification
- `-dno-typeable-binds` remove boilerplate
- `-dsupress-all` hide various internal details
- `-fforce-recomp` forces recompilation
- `-O0`, `-O1`, `-O2` change optimization level
- `-dsupress-uniques` remove mangling

::::
:::: {.column width=50%}

```{=latex}
\onslide<1->
\centering
\includegraphics[height={.8\textheight},trim={0 26.4cm 0 0},clip]{images/ghc-internals/hscpipe2.png}
```

::::
:::

Examples
========

. . .

> example1 :: Int
> example1 = length $ filter (== 'x') ['x', 'y', 'x']

. . .

> example2 :: Int
> example2 = length $ filter (== 'x') "xyx"

. . .

> -- filterNot
> example3 :: (a -> Bool) -> [a] -> [a]
> example3 p xs = filter (not . p) xs

. . .

> example4 :: Char -> Bool
> example4 = (== 'x')

. . .

> data Pair a = MkPair a a
>   deriving Eq

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
