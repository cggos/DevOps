# MkDocs

* [MkDocs](https://www.mkdocs.org/): Project documentation with Markdown.

---

## install

```sh
# python3
pip install mkdocs

# theme material
pip install mkdocs-material

# markdown_extensions
pip install pymdown-extensions
```

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

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

```sh
mkdocs.yml    # The configuration file.
docs/
    index.md  # The documentation homepage.
    ...       # Other markdown pages, images and other files.
```