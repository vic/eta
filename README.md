<p align="center">
  <img src="./eta_logo.png" alt="Eta logo" width="20%" />
</p>



<h1 align="center">Eta - Modern Haskell on the JVM</h1>

[![Join the chat at https://gitter.im/typelead/eta](https://badges.gitter.im/typelead/eta.svg)](https://gitter.im/typelead/eta?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/typelead/eta.svg?branch=master)](https://travis-ci.org/typelead/eta)
[![Build status](https://ci.appveyor.com/api/projects/status/walb8x0befptf86j?svg=true)](https://ci.appveyor.com/project/typelead/eta)


The Eta programming language is a dialect of Haskell which runs on the JVM and has 
the following goals:

- accessibility for beginners from imperative languages, especially Java
- compatibility with GHC 7.10.3's Haskell.

Visit [eta-lang.org](http://eta-lang.org) for instructions on getting started.

## Current Status
**Version:** 0.0.5

Active development is taking place in the following areas:

- Concurrent runtime
- Interactive REPL
- Metaprogramming (TemplateHaskell support)
- Maven support
- Core library support
- Boilerplate generation for Java FFI imports
- Platform-specific installers

Subscribe to the [Eta-Discuss](https://groups.google.com/forum/#!forum/eta-discuss)
for updates.

## Getting Started

Visit the [Getting Started](http://eta-lang.org/docs/html/getting-started.html) page
in the documentation.

## License

Eta is available under the 
[BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause), see `LICENSE`
for more information.

## Gratitude

We would like to specifically thank the following groups/people:
- [GHC HQ](https://ghc.haskell.org/trac/ghc/wiki/TeamGHC) for providing a base for us to work on.
- [Alois Cochard](https://github.com/aloiscochard) for his [codec-jvm](https://github.com/aloiscochard/codec-jvm) package that we use for code generation.
- [Christopher Wells](https://github.com/ExcaliburZero) for his JAR packaging [utility](https://github.com/ExcaliburZero/zip-jar-haskell).
- [Brian McKenna](https://github.com/puffnfresh) for his bug fixes in the codegen/runtime and implementation of basic IO facilities.
- [Sibi](https://github.com/psibi) for helping out with porting packages and setting up Travis.
- [Anton Gushcha](https://github.com/NCrashed) for giving detailed bug reports on the Java FFI.
- [Balaji Rao](https://github.com/balajirrao) for contributing to the design & implementation for some parts of the FFI.

Thank you guys!
