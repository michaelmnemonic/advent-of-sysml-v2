# Initialize project

```bash
sysand init
```

This creates .meta.json and .project.json

# Info about project

```bash
sysand info
```

# Adding content

```bash
sysand add <path/to/sysml/file>
```

# Adding a dependency

https://beta.sysand.org provides a public repository of sysml modules. One can add them like so:

```bash
sysand add <name>
```

Note, that if adding standard library one has to add `--include-std` argument.

# Packaging a project

```bash
sysand build
```

This produces a ".kpar" file for distribution.

# Reproducing environment

```bash
sysand sync
```

# Reproducibility

Hashes of dependencies are stored in ./sysand-lock.toml . Make sure to check it in.