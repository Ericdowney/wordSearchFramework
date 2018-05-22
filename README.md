# Word Search Framework

* Swift: 4.1
* Xcode: 9.3.1

This package contains code for solving a word search grid.  The grid must be square and the first line must contains the words the solver searches for. This package only contains the code and tests for solving a word search grid.  There is no main executable because the swift package manager does not allow for a *main.swift* file in a library package.  This package is a dependency of an executable package that is responsible for using the framework to solve a word search grid.

## Instructions
---

To build the project:

```bash
cd wordSearchFramework
swift build
```

To run tests for the project

```bash
cd wordSearchFramework
swift test
```

The swift package manager does not support code coverage out of the box.  To generate code coverage reports there is some setup.  First, the package needs to have an Xcode projected generated with:

```bash
cd wordSearchFramework
swift package generate-xcodeproj
```

This will also require a ruby gem called *xcov* (https://github.com/nakiostudio/xcov)

```bash
sudo gem install xcov
```

After the Xcode project has been generated and the ruby gem installed, run the following to run tests and generate code coverage reports:

```bash
xcodebuild test -scheme wordSearchFramework-Package -enableCodeCoverage YES; xcov
```

A directory named `xcov_report` will be generated with an *index.html*.