---
title: Semigroups and monoids
subtitle: Functional abstractions
---

Algebraic structures
====================

\ignore{

> import Prelude hiding (Semigroup, Semigroup(..), Monoid, Monoid(..))
> import Data.List.NonEmpty
  
}

```{=latex}
\centering
\begin{quote}
```
Functional abstractions start with algebra
```{=latex}
\end{quote}
```

. . .

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.65\textheight][c]{\linewidth}
\centering
```

. . .

:::::: block

Semigroup $\langle S, \cdot \rangle$
---------

- Set $S$
- Binary operation  
  $\cdot: (S \times S) \rightarrow S$
- *Associativity*  
  $\forall a,b,c \in S : (a \cdot b) \cdot c = a \cdot (b \cdot c)$

::::::

. . .

:::::: block

Monoid $\langle S, \cdot, e \rangle$
------

- Semigroup $\langle S, \cdot \rangle$
- *Identity element* $e \in S$  
  $\forall a \in S : e \cdot a = a \cdot e = a$

::::::

```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

```{=latex}
\onslide<2->
```

```{=latex}
\begin{minipage}[c][.65\textheight][c]{\linewidth}
\centering
```
![](images/monoids/Magma_to_group4.pdf){width=80%}
<https://en.wikipedia.org/wiki/Semigroup>
```{=latex}
\end{minipage}
```

::::
:::

Examples {.fragile}
========

::: columns
:::: {.column width=50%}

```{=latex}
\begin{minipage}[c][.8\textheight][t]{\linewidth}
\centering
```

. . .

:::::: block

Semigroup $\langle S, \cdot \rangle$ \centering
---------

::::: incremental

- *Associativity*  
  $\forall a,b,c \in S : (a \cdot b) \cdot c = a \cdot (b \cdot c)$
- Integers $\mathbb{Z}$
  - $\langle \mathbb{Z}, + \text{ or } \cdot \rangle$
  - $\langle \mathbb{Z}, min \text{ or } max \rangle$
- Power set of $S$
  - $\langle 2^S, \cup \text{ or } \cap \rangle$
- Any semilattice $\langle L, \wedge \rangle$
- Strings
  - $\langle \texttt{String}, \texttt{(++)} \rangle$
- Lists
- Pairs
- Functions

:::::

::::::

```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}

. . .

```{=latex}
\begin{minipage}[c][.8\textheight][t]{\linewidth}
\centering
```

```{=latex}
\renewcommand\hl[1]{\textcolor{CtpGreen}{#1}}
```

:::::: block

Monoid $\langle S, \cdot, \hl{e} \rangle$ \centering
---------

::::: incremental

- *Identity element* \hl{$e \in S$}  
  $\forall a \in S : e \cdot a = a \cdot e = a$
- Integers $\mathbb{Z}$
  - $\langle \mathbb{Z}, + \text{ or } \cdot, \hl{0 \text{ or } 1} \rangle$
  - $\langle \mathbb{Z} \hl{\cup \{ -\infty \text{ or } \infty \}},
    min \text{ or } max, \hl{-\infty \text{ or } \infty} \rangle$
- Power set of $S$
  - $\langle 2^S, \cup \text{ or } \cap, \hl{\emptyset \text{ or } S} \rangle$
- Any semilattice $\langle L, \wedge \rangle$ \hl{with $\top$}
- Strings
  - $\langle \texttt{String}, \texttt{(++)}, \hl{\texttt{""}} \rangle$
- Lists
- Pairs
- Functions

:::::

::::::

```{=latex}
\end{minipage}
```

::::
:::

Haskell
=======

::: columns
:::: {.column width=50%}

[Data.Semigroup](https://hackage.haskell.org/package/base-4.21.0.0/docs/Data-Semigroup.html) \centering
----------------

> class Semigroup a where
>   (<>)    :: a -> a -> a
>   sconcat :: NonEmpty a -> a
>   stimes  :: Integral b => b -> a -> a

Minimal complete definition \centering
---------------------------

\centering

`(<>)` | `sconcat`

. . .

::::
:::: {.column width=50%}

[Data.Monoid](https://hackage.haskell.org/package/base-4.21.0.0/docs/Data-Monoid.html) \phantom{g} \centering
----------------

> class Semigroup a => Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a
>   mconcat :: [a] -> a

Minimal complete definition \centering
---------------------------

\centering

`mempty` | `mconcat`

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
