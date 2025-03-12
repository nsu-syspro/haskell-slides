---
title: Semigroups and monoids
subtitle: Functional abstractions
---

Algebraic structures
====================

\ignore{

> import Prelude hiding (Semigroup, Semigroup(..), Monoid, Monoid(..))

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

Monoid $\langle S, \cdot \rangle$
------

- Semigroup $\langle S, \cdot \rangle$
- *Identity element* $e \in S$  
  $\forall a \in S : e \cdot a = a \cdot e = e$

::::::

```{=latex}
\end{minipage}
```

::::
:::: {.column width=50%}


```{=latex}
\onslide<2->
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

{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
