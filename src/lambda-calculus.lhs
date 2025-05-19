---
title: Lambda calculus
subtitle: Functional models of computation
---

Lambda calculus
===============

\ignore{
  
}

::: columns
:::: {.column width=60%}

History \centering
-------

- 1928 - Hilbert's *Entscheidungsproblem*  
  (German for *Decision problem*)
  - Is there an *algorithm* for deciding whether a proposition
    in first-order logic is true or false?
- 1933 - Recursive functions (*Gödel, Herbrand*)
- 1935 - Untyped $\lambda$-calculus (*Church, Kleene, Rosser*)
- 1936 - Turing machine
- 1936 - Church-Turing thesis
- 1936 - Undecidability of first-order logic
  - Halting problem of Turing machine
  - Equivalence of $\lambda$-terms

::::

. . .

:::: {.column width=40%}

David Hilbert \centering
-------------

- **Haskell Curry**
- Wilhelm Ackermann
- John von Neumann
- Ernst Zermelo
- ...

**Alonzo Church** \centering
-------------

- **Stephen Cole Kleene**
- **J. Barkley Rosser**
- Alan Turing
- Dana Scott
- Michael O. Rabin
- ...

::::
:::

Syntax
======

$$
term ::= \underbrace{var}_{\text{Variable}}\ |\ 
         \underbrace{\app{term}{term}}_{\text{Application}}\ |\ 
         \underbrace{\lam{var}{term}}_{\text{Abstraction}}
$$

Examples
--------

Conventions
-----------

Tree representation
-------------------

$\alpha$-conversion
====================

Free and bound variables
------------------------

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
