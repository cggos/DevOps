# Sphinx

[Sphinx](http://www.sphinx-doc.org) is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license.  

It was originally created for the Python documentation, and it has excellent facilities for the documentation of software projects in a range of languages. Of course, this site is also created from **reStructuredText** sources using **Sphinx**!

* [Sphinx 使用手册](https://zh-sphinx-doc.readthedocs.io)

-----

## reStructuredText

* http://docutils.sourceforge.net/rst.html

## install & build

``` title="requirements.txt"
sphinx
sphinx-rtd-theme
sphinx-markdown-tables
recommonmark
```

* install
  ```sh
  pip install -r docs/requirements.txt
  ```

* build
  ```sh
  cd docs
  make html
  ```
