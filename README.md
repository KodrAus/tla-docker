# An interface to TLA+

A simple containerized interface to TLA+ based on [`tla-bin`](https://github.com/pmer/tla-bin).

## Status

This repository is just a quick experiment. It's not documented or polished or even necessarily working.

## Getting started

Build the container:

```shell
docker build -t tla .
```

Check a PlusCal model in your working directory:

```shell
docker run --rm -v "$(pwd):/src" tla check --build /src/model.tla
```
