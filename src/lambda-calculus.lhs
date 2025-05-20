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

```{=latex}
\renewcommand\hl[1]{\textcolor{CtpBlue}{#1}}
```

David Hilbert \centering
-------------

- \hl{Haskell Curry}
- Wilhelm Ackermann
- John von Neumann
- Ernst Zermelo
- ...

\hl{Alonzo Church} \centering
-------------

- \hl{Stephen Cole Kleene}
- \hl{J. Barkley Rosser}
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
:::: {.column width=50%}

Free variables \centering
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

Bound variables \centering
--------------

\vspace{-2em}

$$
\begin{aligned}
&\text{Variable:}    &BV(x)          &= \emptyset \\
&\text{Application:} &BV(M N)        &= BV(M) \cup BV(N) \\
&\text{Abstraction:} &BV(\lam{x}{M}) &= BV(M) \cup \{x\}
\end{aligned}
$$

::::

:::: {.column width=50%}

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

$\alpha$-conversion
====================

Substitution
------------

$\alpha$-equivalence
--------------------

$\beta$-conversion
==================

$\beta$-reduction
-----------------

$\beta$-abstraction
-------------------

$\eta$-conversion
=================

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
