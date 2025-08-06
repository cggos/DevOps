# MkDocs

* [MkDocs](https://www.mkdocs.org/): Project documentation with Markdown.

---

## Install


### mkdocs

```sh
# python3
pip install mkdocs
```

### theme

#### material

* https://squidfunk.github.io/mkdocs-material/

=== "Latest"
    ```sh
    pip install mkdocs-material
    ```

=== "8.x"
    ```sh
    pip install mkdocs-material=="8.*"
    ```

### extension

```sh
# markdown_extensions
pip install pymdown-extensions
```

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Config

```yaml title="mkdocs.yml"
site_name: DevOps
site_author: Gavin Gao
site_url: https://dev.cgabc.xyz/
site_description:

repo_url: https://github.com/cggos/DevOps
repo_name: cggos/DevOps

theme: 
  name: material # readthedocs material
  # logo: material/library
  favicon: images/favicon.png
  icon:
    repo: fontawesome/brands/git-alt
  nav_style: light
  language: 'zh'
  # palette:
  #   primary: 'light blue'
  #   accent: 'indigo' 
  feature:
    tabs: true
  features:
    - navigation.instant
    - navigation.tracking
    - navigation.tabs
    # - navigation.tabs.sticky
    - navigation.sections
    - navigation.expand
    - navigation.prune
    - navigation.indexes
    - navigation.top
    - toc.follow
    # - toc.integrate
    - content.code.annotate

plugins:
  - search
  # - social
  - tags

markdown_extensions:
  - abbr
  - meta
  - admonition
  - attr_list
  - def_list
  - footnotes
  - toc:
      permalink: true # "#"
      toc_depth: 5
      separator: "_"
      slugify: !!python/name:pymdownx.slugs.uslugify_cased
  - codehilite:
      guess_lang: true
      linenums: true
  - pymdownx.inlinehilite
  - pymdownx.superfences
  - pymdownx.arithmatex
  - pymdownx.critic
  - pymdownx.details
  - pymdownx.magiclink
  - pymdownx.caret
  - pymdownx.mark
  - pymdownx.tilde        
  - pymdownx.smartsymbols
  - pymdownx.snippets
  - pymdownx.highlight:
      auto_title: true
      anchor_linenums: true
      linenums_style: pymdownx-inline
  - pymdownx.tabbed:
      alternate_style: true       
  - pymdownx.betterem:
      smart_enable: all
  - pymdownx.emoji:
      emoji_index: !!python/name:materialx.emoji.twemoji
      emoji_generator: !!python/name:materialx.emoji.to_svg
      # emoji_generator: !!python/name:pymdownx.emoji.to_png
  - pymdownx.tasklist:
      custom_checkbox: true

extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/cggos
      name: cggos on GitHub
    - icon: fontawesome/brands/twitter 
      link: https://twitter.com/CGiABC
      name: CGABC on Twitter
        
nav:
  - Home: 'index.md'
```


## GitHub

- 修改配置文件 **mkdocs.yml** 把 `site_name` 改成项目名称

- 当前目录中的site/目录下的内容推送到远程github的gh-pages分支
  ```sh
  mkdocs build
  mkdocs gh-deploy --clean
  ```

- 访问
  ```sh
  https://{username}.github.io/{projectname}
  ```

## Project layout

```
mkdocs.yml    # The configuration file.
docs/
    index.md  # The documentation homepage.
    ...       # Other markdown pages, images and other files.
```