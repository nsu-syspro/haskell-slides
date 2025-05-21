---
title: Lambda calculus
subtitle: Functional models of computation
---

Lambda calculus {.fragile}
===============

\ignore{
  
}

::: columns
:::: {.column width=65%}

History \centering
-------

- 1928 --- Hilbert's *Entscheidungsproblem* ^[German for "decision problem"]
  - Is there an *algorithm* for deciding whether a proposition
    in first-order logic is true or false?
- Replacement for set theory as foundation of mathematics
  - 1930 --- Combinatory logic (*Curry, Schönfinkel*)
  - 1932 --- $\lambda$-calculus (*Church*)
  - 1935 --- Kleene--Rosser paradox
- Effective computability
  - 1935 --- Untyped $\lambda$-calculus (*Church, Kleene, Rosser*)
  - 1936 --- Turing machine
  - 1936 --- Church--Turing thesis
- 1936 --- Undecidability of first-order logic
  - Halting problem of Turing machine
  - Equivalence of $\lambda$-terms

::::

. . .

:::: {.column width=35%}

David Hilbert \centering
-------------

- \cemph{Haskell Curry}
- Wilhelm Ackermann
- John von Neumann
- Ernst Zermelo
- ...

\cemph{Alonzo Church} \centering
-------------

- \cemph{Stephen Cole Kleene}
- \cemph{J. Barkley Rosser}
- Alan Turing
- Dana Scott
- Michael O. Rabin
- ...

::::
:::

Untyped lambda calculus
=======================

::: columns
:::: {.column width=50%}

Syntax \centering
------

\vspace{-2.5em}

$$
term ::= \underbrace{var}_{\text{Variable}}\ |\ 
         (\underbrace{\app{term}{term}}_{\text{Application}})\ |\ 
         (\underbrace{\lam{var}{term}}_{\text{Abstraction}})
$$

\vspace{-1.5em}

Examples \centering
--------

\vspace{-2.5em}

$$
\lam{x}{x} \qquad (\lam{x}{x x})(\lam{y}{y y}) \qquad \lam{f}{\lam{x}{f (f x)}}
$$

\vspace{-1.5em}

Conventions \centering
-----------

- Application is left associative  
  $a b c = (a b) c$
- Abstraction is right associative  
  $\lam{x}{\lam{y}{x}}= \lam{x}{(\lam{y}{x})}$
- Consecutive abstractions can be combined  
  $\lam{x}{\lam{y}{x}}= \lam{x y}{x}$

::::

. . .

:::: {.column width=50%}

Tree representation \centering
-------------------

```{=latex}
\centering

\begin{minipage}[t]{.4\columnwidth}
\centering

$\lam{x}{x}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 3/.style={sibling distance=3em}
  ]

  \node {$\lambda x$}
    child {node {x}
    };

\end{tikzpicture}
\end{minipage}
\vspace{2em}

\begin{minipage}[t]{.4\columnwidth}
\centering

$(\lam{x}{x x})(\lam{y}{y y})$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 3/.style={sibling distance=3em}
  ]

  \node {@}
    child {node {$\lambda x$}
      child {node {@}
        child {node {x}}
        child {node {x}}
      }
    }
    child {node {$\lambda y$}
      child {node {@}
        child {node {y}}
        child {node {y}}
      }
    };

\end{tikzpicture}
\end{minipage}
\begin{minipage}[t]{.4\columnwidth}
\centering

$\lam{f}{\lam{x}{f (f x)}}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 3/.style={sibling distance=3em}
  ]

  \node {$\lambda f$}
    child {node {$\lambda x$}
      child {node {@}
        child {node {f}}
        child {node {@}
          child {node {f}}
          child {node {x}}
        }
      }
    };

\end{tikzpicture}
\end{minipage}
```


::::
:::

Free and bound variables {.fragile}
========================

::: columns
:::: {.column width=55%}

Free variables $FV(t)$ \centering
--------------

\vspace{-2em}

$$
\begin{aligned}
&\text{Variable:}    &FV(x)          &= \{x\} \\
&\text{Application:} &FV(M N)        &= FV(M) \cup FV(N) \\
&\text{Abstraction:} &FV(\lam{x}{M}) &= FV(M)\ \backslash\ \{x\}
\end{aligned}
$$

\vspace{-1.5em}

Bound variables $BV(t)$ \centering
---------------

\vspace{-2em}

$$
\begin{aligned}
&\text{Variable:}    &BV(x)          &= \emptyset \\
&\text{Application:} &BV(M N)        &= BV(M) \cup BV(N) \\
&\text{Abstraction:} &BV(\lam{x}{M}) &= BV(M) \cup \{x\}
\end{aligned}
$$

\vspace{-1.5em}

Closed terms \centering
------------

Term $t$ is called \cemph{closed} or \cemph{combinator} if $FV(t) = \emptyset$

::::

:::: {.column width=45%}

Example \centering
-------

```{=latex}
\centering

\begin{minipage}[t]{.4\columnwidth}
\centering

\newcommand\fv[1]{\textcolor{CtpBlue}{#1}}
\newcommand\bvx[1]{\textcolor{CtpRed}{#1}}
\newcommand\bvy[1]{\textcolor{CtpGreen}{#1}}

$\lam{\bvx{x}}{(\lam{\bvy{y}}{\bvy{y} \bvx{x}}) \fv{z}}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 3/.style={sibling distance=3em}
  ]

  \node (lx) {$\lambda \bvx{x}$}
    child {node {@}
      child {node (ly) {$\lambda \bvy{y}$}
        child {node {@}
          child {node (y) {\bvy{y}}}
          child {node (x) {\bvx{x}}}
        }
      }
      child {node {\fv{z}}}
    };

  \draw[->,CtpRed] (x) to[bend right=80,distance=5em] (lx);
  \draw[->,CtpGreen] (y) to[bend left=60] (ly);

\end{tikzpicture}
\end{minipage}
```


::::
:::

Substitution {.fragile}
========================

::: columns
:::: {.column width=50%}

Substitution $\subst{t}{v}{S}$ \centering
------------

\vspace{-1em}

$$
\begin{aligned}
\subst{x}{v}{S} &=
  \begin{cases}
  S & v = x \\
  x & v \neq x
  \end{cases} \\
\subst{(M N)}{v}{S}  &= (\app{\subst{M}{v}{S}}{\subst{N}{v}{S}}) \\
\subst{(\lam{x}{M})}{v}{S} &=
  \begin{cases}
  \lam{x}{M} & v = x \\
  \lam{x}{\subst{M}{v}{S}} & v \neq x
  \end{cases} \\
\end{aligned}
$$

Safe substitution \centering
-----------------

Substitution $\subst{t}{v}{S}$ is \cemph{safe} if $BV(t) \cap FV(S) = \emptyset$

::::

:::: {.column width=50%}

Example \centering
-------

```{=latex}
\centering

\newcommand\fv[1]{\textcolor{CtpBlue}{#1}}
\newcommand\good[1]{\textcolor{CtpGreen}{#1}}
\newcommand\bad[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{.9\columnwidth}
\centering

$\subst{(\lam{x}{x \fv{y}})}{\fv{y}}{\good{\lam{z}{z}}} = \lam{x}{x (\good{\lam{z}{z}})}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (lx1) {$\lambda x$}
    child {node {@}
      child {node (x1) {$x$}}
      child {node (y1) {$\fv{y}$}}
    };

  \node [fit=(lx1) (x1) (y1)] (lam1) {};

  \node [right=6em of lx1] (lx2) {$\lambda x$}
    child {node {@}
      child {node (x2) {$x$}}
      child {node [CtpGreen] (y2) {$\lambda z$}
        child [CtpGreen] {node {$z$}}
      }
    };

  \node [fit=(lx2) (x2) (y2)] (lam2) {};

  \draw [->] (lam1) -- node [below] {\small $\subst{}{\fv{y}}{\good{\lam{z}{z}}}$} (lam2);

\end{tikzpicture}
\end{minipage}
\vspace{0.5em}

\begin{minipage}[t]{.9\columnwidth}
\centering

$\subst{(\lam{x}{x \fv{y}})}{\fv{y}}{\bad{x}} = \lam{x}{x \bad{x}}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (lx1) {$\lambda x$}
    child {node {@}
      child {node (x1) {$x$}}
      child {node (y1) {$\fv{y}$}}
    };

  \node [fit=(lx1) (x1) (y1)] (lam1) {};

  \node [right=6em of lx1] (lx2) {$\lambda x$}
    child {node {@}
      child {node (x2) {$x$}}
      child {node (y2) {$\bad{x}$}}
    };

  \draw[->,CtpRed] (y2) to[bend right=60] node[pos=0.40,sloped,cross out,draw] {} (lx2);

  \node [fit=(lx2) (x2) (y2)] (lam2) {};

  \draw [->] (lam1) -- node [below] {\small $\subst{}{\fv{y}}{\bad{x}}$} (lam2);

\end{tikzpicture}
\end{minipage}
```


::::
:::

Renaming {.fragile}
========

::: columns
:::: {.column width=50%}

\onslide<3->

$\alpha$-equivalence \centering
--------------------

\vspace{-1em}

$$
\begin{aligned}
\lam{x}{M} &\underset{\alpha}{\equiv} \lam{y}\subst{M}{x}{y} & &\text{ \cemph{if} } x \notin FV(M) \\
\lam{x}{M} &\underset{\alpha}{\equiv} \lam{x}{N} & &\text{ \cemph{if} } M \underset{\alpha}{\equiv} N \\
M P &\underset{\alpha}{\equiv} N P & &\text{ \cemph{if} } M \underset{\alpha}{\equiv} N \\
P M &\underset{\alpha}{\equiv} P N & &\text{ \cemph{if} } M \underset{\alpha}{\equiv} N
\end{aligned}
$$

\vspace{-1em}

Conventions \centering
-----------

- $\lambda$-terms are considered \cemph{identical} up to $\alpha$-equivalence
- Appropriate renaming happens \cemph{implicitly} if required during substitution

::::

:::: {.column width=50%}

\onslide<1->

Problem \centering
-------

```{=latex}
\centering

\newcommand\fv[1]{\textcolor{CtpBlue}{#1}}
\newcommand\good[1]{\textcolor{CtpGreen}{#1}}
\newcommand\bad[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{.9\columnwidth}
\centering

$\subst{\lam{x}{x \fv{y}}}{\fv{y}}{\bad{x}} = \lam{x}{x \bad{x}}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (lx1) {$\lambda x$}
    child {node {@}
      child {node (x1) {$x$}}
      child {node (y1) {$\fv{y}$}}
    };

  \node [fit=(lx1) (x1) (y1)] (lam1) {};

  \node [right=6em of lx1] (lx2) {$\lambda x$}
    child {node {@}
      child {node (x2) {$x$}}
      child {node (y2) {$\bad{x}$}}
    };

  \draw[->,CtpRed] (y2) to[bend right=60] node[pos=0.40,sloped,cross out,draw] {} (lx2);

  \node [fit=(lx2) (x2) (y2)] (lam2) {};

  \draw [->] (lam1) -- node [below] {\small $\subst{}{\fv{y}}{\bad{x}}$} (lam2);

\end{tikzpicture}
\end{minipage}
```

\vspace{-1em}

\onslide<2->

Solution \centering
--------

```{=latex}
\centering

\newcommand\fv[1]{\textcolor{CtpBlue}{#1}}
\newcommand\good[1]{\textcolor{CtpGreen}{#1}}
\newcommand\bad[1]{\textcolor{CtpRed}{#1}}
\newcommand\changed[1]{\textcolor{CtpGreen}{#1}}

\newcommand\ualpha{\uncover<3->{\alpha}}

\begin{minipage}[t]{.9\columnwidth}
\centering

$\subst{(\lam{x}{x \fv{y}})}{\fv{y}}{\bad{x}} \underset{\ualpha}{\equiv}
 \subst{(\lam{\changed{z}}{\changed{z} \fv{y}})}{\fv{y}}{\bad{x}} =
 \lam{\changed{z}}{\changed{z} \bad{x}}$

\vspace{0.5em}
\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (lx1) {$\lambda x$}
    child {node {@}
      child {node (x1) {$x$}}
      child {node (y1) {$\fv{y}$}}
    };

  \node [fit=(lx1) (x1) (y1)] (lam1) {};

  \node [right=6em of lx1] (lx2) {$\lambda \changed{z}$}
    child {node {@}
      child {node (x2) {$\changed{z}$}}
      child {node (y2) {$\fv{y}$}}
    };

  \node [fit=(lx2) (x2) (y2)] (lam2) {};

  \node [right=6em of lx2] (lx3) {$\lambda \changed{z}$}
    child {node {@}
      child {node (x3) {$\changed{z}$}}
      child {node (y3) {$\bad{x}$}}
    };

  \node [fit=(lx3) (x3) (y3)] (lam3) {};

  \draw [->] (lam1) -- node [below] {\small $\ualpha$} (lam2);
  \draw [->] (lam2) -- node [below] {\small $\subst{}{\fv{y}}{\bad{x}}$} (lam3);

\end{tikzpicture}
\end{minipage}
```


::::
:::

Evaluation {.fragile .t}
==========

::: columns
:::: {.column width=52%}

::::: {.block}

Definitions \centering
-----------

- Subterm of form \textcolor{CtpPeach}{$(\lam{x}{M}) N$} is called \cemph{$\beta$-redex}
- Redex \textcolor{CtpPeach}{$(\lam{x}{M}) N$} can be \cemph{reduced} to \textcolor{CtpPeach}{$\subst{M}{x}{N}$}
- $M \rightarrow_{\beta} M'$ denotes single \cemph{$\beta$-reduction}
- $M \twoheadrightarrow_{\beta} M'$ denotes several $\beta$-reductions
- $M \leftrightarrow_{\beta} M'$ denotes \cemph{$\beta$-conversion} as
  smallest equivalence relation containing $\rightarrow_{\beta}$

:::::

```{=latex}
\begin{onlyenv}<1-2>
```

::::: {.block}

$\beta$-reduction \centering
------------------

\vspace{-1em}

$$
\begin{aligned}
(\lam{x}{M}) N &\rightarrow_{\beta} \subst{M}{x}{N} \\
\lam{x}{M} &\rightarrow_{\beta} \lam{x}{N} & &\text{ \cemph{if} } M \rightarrow_{\beta} N \\
M P &\rightarrow_{\beta} N P & &\text{ \cemph{if} } M \rightarrow_{\beta} N \\
P M &\rightarrow_{\beta} P N & &\text{ \cemph{if} } M \rightarrow_{\beta} N
\end{aligned}
$$

:::::

```{=latex}
\end{onlyenv}
```

```{=latex}
\begin{onlyenv}<3->
```

:::::{.block}

$\beta$-conversion \centering
------------------

```{=latex}
\centering

\begin{minipage}[t]{\columnwidth}
\centering

\begin{tikzpicture}

  \matrix [row sep=1em, column sep=3em,ampersand replacement=\&] {
  \node (M1) {M}; \&                \&                \&                 \& \node (M2) {M'}; \\
                  \&                \& \node (B) {B}; \&                 \& \\
                  \& \node (A) {A}; \&                \&  \node (C) {C}; \& \\
  };
  \draw [<->] (M1) -- node [below] {\small $\beta$} (M2);
  \draw [->>,densely dotted] (M1) -- node [below left] {\small $\beta$} (A);
  \draw [->>,densely dotted] (B)  -- node [below right] {\small $\beta$} (A);
  \draw [->>,densely dotted] (B)  -- node [below left] {\small $\beta$} (C);
  \draw [->>,densely dotted] (M2) -- node [below right] {\small $\beta$} (C);

\end{tikzpicture}
\end{minipage}
```

:::::

```{=latex}
\end{onlyenv}
```

::::

. . .

:::: {.column width=48%}

Example \centering
-------

```{=latex}
\centering

\newcommand\lzz[1]{\textcolor{CtpBlue}{#1}}
\newcommand\cx[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{\columnwidth}
\centering

\vspace{-2em}

$$
\begin{aligned}
(\lam{x}{\underline{(\lam{y}{y \cx{x}}) (\lzz{\lam{z}{z}})}})&\ \rightarrow_{\beta} \\
(\lam{x}{\underline{(\lzz{\lam{z}{z}}) \cx{x}}})&\ \rightarrow_{\beta} \lam{x}{\cx{x}}
\end{aligned}
$$

\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (t1) {$\lambda x$}
    child {node (a1) {@}
      child {node (l1) {$\lambda y$}
        child {node (b1) {@}
          child {node (y1) {$y$}}
          child {node (x1) {$\cx{x}$}}
        }
      }
      child {node [CtpBlue] (r1) {$\lambda z$}
        child [CtpBlue] {node (z1) {$z$}}
      }
    };

  \draw \convexpath{y1,l1,a1,r1,z1,x1}{1em};

  \node [fit=(t1) (l1) (r1)] (lam1) {};

  \node [right=6em of t1] (t2) {$\lambda x$}
    child {node (a2) {@}
      child {node [CtpBlue] (l2) {$\lambda z$}
        child [CtpBlue] {node (z2) {$z$}}
      }
      child {node (r2) {$\cx{x}$}}
    };

  \draw \convexpath{z2,l2,a2,r2}{1em};

  \node [fit=(t2) (l2) (r2)] (lam2) {};

  \node [right=4em of t2] (t3) {$\lambda x$}
    child {node (l3) {$\cx{x}$}
    };

  \node [fit=(l3)] (lam3) {};

  \draw [->] (lam1) -- node [below] {\small $\beta$} (lam2);
  \draw [->] (lam2) -- node [below] {\small $\beta$} (lam3);

\end{tikzpicture}
\end{minipage}
```

. . .


::::
:::

Reduction order {.fragile}
===============

::: columns
:::: {.column width=50%}

Normal order \centering
------------

- Term without any redex is in \cemph{$\beta$-normal form}
- Reduction sequence that always reduces leftmost outermost redex
  is called \cemph{normal order reduction}

Example \centering
-------

\vspace{-2em}

```{=latex}
\newcommand\ra[1]{\textcolor{CtpRed}{#1}}
\newcommand\rf[1]{\textcolor{CtpGreen}{#1}}
\newcommand\rg[1]{\textcolor{CtpBlue}{#1}}
\renewcommand\ul[2]{{\color{#1}\underline{{\color{main} #2}}}}
```

$$
\begin{aligned}
\ul{CtpRed}{(\lam{z}{\app{\ul{CtpGreen}{((\lam{x}{x z}) \rf{f})}}{\ul{CtpBlue}{((\lam{y}{y z}) \rg{g})}}}) \ra{a}}
&\rightarrow_{\beta} \\
\app{\ul{CtpGreen}{((\lam{x}{x \ra{a}}) \rf{f})}}{\ul{CtpBlue}{((\lam{y}{y \ra{a}}) \rg{g})}}
&\rightarrow_{\beta} \\
\app{(\rf{f} \ra{a})}{\ul{CtpBlue}{((\lam{y}{y \ra{a}}) \rg{g})}}
&\rightarrow_{\beta}
\app{(\rf{f} \ra{a})}{(\rg{g} \ra{a})}
\end{aligned}
$$

::::

. . .

:::: {.column width=50%}

Totality \centering
--------

. . .

\vspace{-1em}

$$
\begin{aligned}
\Omega = \underline{(\lam{x}{x x}) (\lam{x}{x x})}
&\rightarrow_{\beta} \\
\subst{(x x)}{x}{(\lam{x}{x x})}
&\rightarrow_{\beta} \\
\underline{{(\lam{x}{x x}) (\lam{x}{x x})}}
&\rightarrow_{\beta} \dots
\end{aligned}
$$

. . .

\centering

$\Omega$ has \cemph{no $\beta$-normal form}

\vspace{0.5em}

. . .

Strictness \centering
----------

. . .

\vspace{-1em}

$$
\begin{aligned}
\underline{(\lam{x}{y})\Omega}
\rightarrow_{\beta} y
\end{aligned}
$$

. . .

\centering

Normal order reduction models  
\cemph{non-strict} or \cemph{lazy} evaluation

::::
:::

Reduction order {.fragile}
===============

::: columns
:::: {.column width=54%}

\onslide<2->

Church--Rosser theorem \centering
----------------------

If $M \leftrightarrow_{\beta} M'$ then there exists $N$
such that $M \twoheadrightarrow_{\beta} N$ and $M' \twoheadrightarrow_{\beta} N$

\onslide<3->

Confluence property \centering
-------------------

If $M \twoheadrightarrow_{\beta} P$ and $M \twoheadrightarrow_{\beta} Q$ then there exists $N$
such that $P \twoheadrightarrow_{\beta} N$ and $Q \twoheadrightarrow_{\beta} N$

\onslide<4->

Corollary \centering
---------

$\beta$-normal form is \cemph{unique} up to $\alpha$-equivalence

\onslide<5->

Normal order theorem \centering
--------------------

If $M \twoheadrightarrow_{\beta} N$ and $N$ is in $\beta$-normal form
then there exists \cemph{normal order reduction} sequence from $M$ to $N$

::::

:::: {.column width=46%}

\onslide<2->

Church--Rosser \centering
--------------

```{=latex}
\centering

\newcommand\lzz[1]{\textcolor{CtpBlue}{#1}}
\newcommand\cx[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{\columnwidth}
\centering

\begin{tikzpicture}

  \matrix [row sep=3.0em, column sep=3.0em,ampersand replacement=\&] {
  \node (M1) {M}; \& \& \node (M2) {M'}; \\
  \& \node (N) {N}; \& \\
  };
  \draw [<->] (M1) -- node [below] {\small $\beta$} (M2);
  \draw [->>,densely dotted] (M1) -- node [below left] {\small $\beta$} (N);
  \draw [->>,densely dotted] (M2) -- node [below right] {\small $\beta$} (N);

\end{tikzpicture}
\end{minipage}
```

\onslide<3->

Confluence \centering
----------

```{=latex}
\centering

\newcommand\lzz[1]{\textcolor{CtpBlue}{#1}}
\newcommand\cx[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{\columnwidth}
\centering

\begin{tikzpicture}

  \matrix [row sep=3.0em, column sep=3.0em,ampersand replacement=\&] {
  \& \node (M) {M}; \& \\
  \node (P) {P}; \& \& \node (Q) {Q}; \\
  \& \node (N) {N}; \& \\
  };
  \draw [->>] (M) -- node [above left] {\small $\beta$} (P);
  \draw [->>] (M) -- node [above right] {\small $\beta$} (Q);
  \draw [->>,densely dotted] (P) -- node [below left] {\small $\beta$} (N);
  \draw [->>,densely dotted] (Q) -- node [below right] {\small $\beta$} (N);

\end{tikzpicture}
\end{minipage}
```

::::
:::

Recursion
=========

Fixed-point combinator \centering
----------------------

\vspace{-1em}

$$
Y f \leftrightarrow_{\beta} f (Y f)
$$

\vspace{-1em}

Curry's $Y$-combinator \centering
------------------------------

\vspace{-1em}

$$
Y = \lam{f}{\app{
  (\lam{x}{f(xx)})
}{
  (\lam{x}{f(xx)})
}}
$$

. . .

\centering

\textcolor{CtpOverlay2}{Note: neither $Y f \rightarrow_{\beta} f (Y f)$
nor $f (Y f) \rightarrow_{\beta} Y f$}

. . .

Turing's $\Theta$-combinator \centering
-------------------------------

\vspace{-1em}

$$
\Theta = \app{
  (\lam{xy}{x(xxy)})
}{
  (\lam{xy}{x(xxy)})
}
$$

. . .

\centering

\textcolor{CtpOverlay2}{Note: $\Theta f \rightarrow_{\beta} f (\Theta f)$}

Church-Turing thesis
====================

Undecidability
--------------

Programming foundation
======================

Church numerals
---------------

Relation to folds
-----------------

Algebraic data types
--------------------

Predecessor
-----------

$\eta$-conversion
=================

$\eta$-conversion \centering
-----------------

\vspace{-1em}

$$
(\lam{x}{M x}) \underset{\eta}{\longleftrightarrow} M \text{ \cemph{if} } x \notin FV(M)
$$


{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
