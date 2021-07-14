# Starter Docker - GitHub Actions

- Run actions with docker (latest version)
- Quick and easy to use
- Support custom registry
- Support custom shell and commands

# Usage

```yaml
- name: Starter Docker
  uses: CUBETIQ/starter-docker-actions@main
```

# Example Action

```yaml
name: CI

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Starter Docker Test
        uses: cubetiq/starter-docker-actions@main
        with:
          shell: sh
          run: docker version
```

# Contributors

- Sambo Chea <sombochea@cubetiqs.com>
