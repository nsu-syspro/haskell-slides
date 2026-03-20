# Presentations for NSU Sys.Pro course "Functional Programming"

Rendered presentations are located in directory [publish](publish):

- Course introduction ([pdf](publish/intro.pdf?raw=true), [md](src/intro.md))
- **Functional programming in Haskell**
  - Introduction to Haskell ([pdf](publish/haskell-intro.pdf?raw=true), [lhs](src/haskell-intro.lhs))
- **Functional abstractions**
  - Semigroups and monoids ([pdf](publish/monoids.pdf?raw=true), [lhs](src/monoids.lhs))
  - Foldable ([pdf](publish/foldable.pdf?raw=true), [lhs](src/foldable.lhs))
  - Functor ([pdf](publish/functor.pdf?raw=true), [lhs](src/functor.lhs))
- **Functional models of computation**
  - Lambda calculus ([pdf](publish/lambda-calculus.pdf?raw=true), [lhs](src/lambda-calculus.lhs))
  - GHC internals by example ([pdf](publish/ghc-internals.pdf?raw=true), [lhs](src/ghc-internals.lhs))

## Building

Following command builds presentations into `.pdf`:

```
make
```

## Publishing

To "publish" the final `.pdf` you can use the following command which builds and copies `src/*.pdf` into `publish/*.pdf`
which can then be committed to the repo:

```
make publish
```
