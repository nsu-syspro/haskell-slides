---
title: Lambda calculus
subtitle: Functional models of computation
---

Lambda calculus
===============

\ignore{
  
}

- History


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
