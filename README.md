# Presentations for NSU Sys.Pro course "Functional Programming"

Rendered presentations are located in directory [publish](publish):

- Course introduction ([pdf](publish/intro.pdf?raw=true), [md](src/intro.md))
- **Functional programming in Haskell**
  - Introduction to Haskell ([pdf](publish/haskell-intro.pdf?raw=true), [lhs](src/haskell-intro.lhs))
- **Functional abstractions**
- **Functional models of computation**

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
