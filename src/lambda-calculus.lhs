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

- 1928 - Hilbert's *Entscheidungsproblem* ^[German for "decision problem"]
  - Is there an *algorithm* for deciding whether a proposition
    in first-order logic is true or false?
- Replacement for set theory as foundation of mathematics
  - 1930 - Combinatory logic (*Curry, Schönfinkel*)
  - 1932 - $\lambda$-calculus (*Church*)
  - 1935 - Kleene-Rosser paradox
- Effective computability
  - 1935 - Untyped $\lambda$-calculus (*Church, Kleene, Rosser*)
  - 1936 - Turing machine
  - 1936 - Church-Turing thesis
- 1936 - Undecidability of first-order logic
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

Syntax
======

::: columns
:::: {.column width=50%}

Grammar \centering
-------

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
      child {node (y2) {$\good{\lambda z}$}
        child {node {$\good{z}$}}
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

Evaluation {.fragile}
==========

::: columns
:::: {.column width=52%}

Definitions \centering
-----------

- Subterm of form $(\lam{x}{M}) N$ is called \cemph{$\beta$-redex}
- Redex $(\lam{x}{M}) N$ can be \cemph{reduced} to $\subst{M}{x}{N}$
- Reduction of single redex in term $M$ is called \cemph{$\beta$-reduction} and denoted as $M \rightarrow_{\beta} M'$
- $\beta$-reduction in multiple steps is denoted as $M \twoheadrightarrow_{\beta} M'$

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

::::

. . .

:::: {.column width=48%}

Example \centering
-------

```{=latex}
\centering

\newcommand\redex[1]{\textcolor{CtpBlue}{#1}}
\newcommand\redexarg[1]{\textcolor{CtpRed}{#1}}
\newcommand\redexvar[1]{\textcolor{CtpGreen}{#1}}
\newcommand\good[1]{\textcolor{CtpGreen}{#1}}
\newcommand\bad[1]{\textcolor{CtpRed}{#1}}

\begin{minipage}[t]{\columnwidth}
\centering

\vspace{-2em}

$$
\begin{aligned}
(\lam{x}{\redex{(\lam{\redexvar{y}}{\redexvar{y} x})} \redexarg{(\lam{z}{z})}})&\ \rightarrow_{\beta} \\
(\lam{x}{\redex{(\lam{\redexvar{z}}{\redexvar{z}})} \redexarg{x}})&\ \rightarrow_{\beta} \\
\lam{x}{x}&
\end{aligned}
$$

\begin{tikzpicture}[
    level distance=2.5em,
    level 2/.style={sibling distance=3em}
  ]

  \node (t1) {$\lambda x$}
    child {node [CtpBlue] {@}
      child [CtpBlue] {node (l1) {$\lambda \redexvar{y}$}
        child {node {@}
          child {node {$\redexvar{y}$}}
          child {node {$x$}}
        }
      }
      child [CtpBlue] {node [CtpRed] (r1) {$\lambda z$}
        child [CtpRed] {node {$z$}}
      }
    };

  \node [fit=(t1) (l1) (r1)] (lam1) {};

  \node [right=6em of t1] (t2) {$\lambda x$}
    child {node [CtpBlue] {@}
      child [CtpBlue] {node (l2) {$\lambda \redexvar{z}$}
        child {node {$\redexvar{z}$}}
      }
      child [CtpBlue] {node [CtpRed] (r2) {$x$}}
    };

  \node [fit=(t2) (l2) (r2)] (lam2) {};

  \node [right=4em of t2] (t3) {$\lambda x$}
    child {node (l3) {$x$}
    };

  \node [fit=(l3)] (lam3) {};

  \draw [->] (lam1) -- node [below] {\small $\beta$} (lam2);
  \draw [->] (lam2) -- node [below] {\small $\beta$} (lam3);

\end{tikzpicture}
\end{minipage}
```

::::
:::

$\eta$-conversion
=================

$\eta$-conversion \centering
-----------------

\vspace{-1em}

$$
(\lam{x}{M x}) \underset{\eta}{\longleftrightarrow} M \text{ \cemph{if} } x \notin FV(M)
$$

Convertibility
==============

Normal order reduction
======================

First Church-Rosser theorem
---------------------------

Second Church-Rosser theorem
----------------------------

Normal order reduction
----------------------

Recursion
=========

Fixed-point combinator
----------------------

Curry's $Y$-combinator
------------------------------

$$
Y = \lam{f}{\app{
  (\lam{x}{f(xx)})
}{
  (\lam{x}{f(xx)})
}}
$$

Turing's $\Theta$-combinator
-------------------------------

$$
\Theta = \app{
  (\lam{xy}{x(xxy)})
}{
  (\lam{xy}{x(xxy)})
}
$$

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


{.plain}
========

\centering
```{=latex}
{\fontsize{48pt}{7.2}\selectfont Q\&A }
```

\ignore{

> main = pure ()

}
