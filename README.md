# Arquivo Static Site Generator: A GitHub Action

This GitHub Action converts [arquivo notebook](https://github.com/phillmv/arquivo) exports, or folders with ad-hoc markdown files, into a static site.

It then pushes this static site to any given repo, so that it may be hosted as a GitHub Page.

## What do you mean by ad-hoc Markdown files?

I mean, files ending in `.md` or `.markdown` whose contents look like this:

```
---
occurred_at: 2021-12-31
---

# hello world

this is valid markdown, with a yaml front-matter.
```

will be converted to html. Also, any non markdown files will be copied over as well.

## Working example

Add the following to your own repo, under the `.github/workflows/arquivo.yml` file path.

```yaml
name: Arquivo Static Export

on:
  workflow_dispatch:
  push:
    branches: [main]

jobs:
  build_and_deploy:
    name: Build & Deploy
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & Deploy to GitHub Pages
        uses: phillmv/arquivo-export@main
```
