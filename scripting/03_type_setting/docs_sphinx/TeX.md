# TeX

* [TeX Users Group (TUG)](http://www.tug.org/)
* [The Com­pre­hen­sive TEX Archive Net­work (CTAN)](https://ctan.org/)
* [LaTeX科技排版工作室](http://www.latexstudio.net/)

* [LaTeX Community](https://latex.org/forum/)
* [LaTeX Tutorial](https://www.latex-tutorial.com)
* [LaTex from WiKiBooks](https://en.wikibooks.org/wiki/LaTeX)
* [LaTeX-materials](https://github.com/BIT-thesis/LaTeX-materials)
* [mathtextutorial (forkosh)](http://www.forkosh.com/mathtextutorial.html): LaTeX Practice Box
* [Overleaf LaTeX Documentation](https://www.overleaf.com/learn/latex/Main_Page)

* LaTeX Algorithms
  - [LaTeX/Algorithms(wikibook)](https://en.wikibooks.org/wiki/LaTeX/Algorithms)
  - [How to write algorithm in Latex](http://shantoroy.com/latex/how-to-write-algorithm-in-latex/)

-----

[TOC]


# TeX发行版

* [各个操作系统下的TeX发行版(清华大学开源软件镜像站)](https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/)

* [TeX Live](http://www.tug.org/texlive/)
* [MiKTeX](https://miktex.org/)
* [Chinese TeX](http://www.ctex.org/HomePage)


# TeX Templates

* [LaTeX Templates](http://www.latextemplates.com/)
* [北京理工大学硕士（博士）学位论文LaTeX模板](https://github.com/BIT-thesis/LaTeX-template)


# TeX on ubuntu

* [Ubuntu下部署Latex编译环境](http://ptbsare.org/2014/05/12/ubuntu%E4%B8%8B%E9%83%A8%E7%BD%B2latex%E7%BC%96%E8%AF%91%E7%8E%AF%E5%A2%83/#1_-从源里面安装)
  ```sh
  sudo apt install texlive-full
  sudo apt install texmaker

  # optional
  # 安装中文字体包，字体包中包含bsmi，bkai，gkai，gbsn四种中文字体
  # bsmi和bkai是Big5编码的宋体和楷体字；后两者gkai和gbsn分别处理简体中文楷体字和宋体字
  sudo apt install latex-cjk-all
  ```

* ubuntu 16.04下的latex的section没有编号的问题
  - 从 https://www.ctan.org/tex-archive/macros/latex/contrib/titlesec 下载解压到 `/usr/share/texlive/texmf-dist/tex/latex`

# TeX Editor

* [Tables Generator](https://www.tablesgenerator.com/): Create LaTeX tables online

* [TeXworks](http://www.tug.org/texworks/)
* [TeXstudio](https://www.texstudio.org/)
* [TeXMaker](http://www.xm1math.net/texmaker/): Free cross-platform LaTeX editor since 2003
* [LyX](https://www.lyx.org/): The Document Processor
* [Overleaf](https://www.overleaf.com/)
* [ShareLaTeX, Online TeX Editor](https://www.sharelatex.com/)
* [TeXample.net](http://www.texample.net/)
* [Visual Studio Code LaTeX Workshop Extension](https://github.com/James-Yu/LaTeX-Workshop)
* [Upmath](https://upmath.me/): Markdown & LaTeX Online Editor


# TeX with Make

```sh
sudo apt install latexmk texlive texlive-science
```

* [How to properly 'make' a latex project?](https://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project)
  - example: [jlblancoc/tutorial-se3-manifold](https://github.com/jlblancoc/tutorial-se3-manifold)


# Beamer Slides with LaTeX

* [Urinx/LaTeX-PPT-Template](https://github.com/Urinx/LaTeX-PPT-Template): Seven awesome latex ppt templates for researchers or students
* [beamer-theme-matrix](https://hartwork.org/beamer-theme-matrix/)
* [slides](https://github.com/wzpan/wzpan.github.io/wiki/slides)

# Curriculum Vitæ with TeX

* [Writing the curriculum vitæ with LaTeX](http://tug.org/pracjourn/2007-4/mori/)
* [moderncv 的笔记](https://www.xiangsun.org/tex/notes-on-moderncv)
