# Dockerized CDK with Python version support

## Description

Dockerized Typescript and Python version of CDK.
It's a common issue that people are running CDK with different versions in projects
and every now and then that becomes an larger issue.
This provides a common all around and available dockerized version of CDK which
can be used in developer's machines or via pipeline.

Dockerfile follows best practices and i.e. runs as an unprivileged user.

## Usage

In general, see `Makefile` targets.

### Building

Build a generally available CDK:

```bash
make build
```
