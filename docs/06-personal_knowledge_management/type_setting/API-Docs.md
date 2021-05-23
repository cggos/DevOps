# API Docs

* [CodeDocs](https://codedocs.xyz/) will generate and publish documentation for you, using Doxygen. It's free and easy to setup with your public GitHub repositories.

-----

[TOC]

## Doxygen

[Doxygen](http://www.stack.nl/~dimitri/doxygen) is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.

### 使用Doxygen生成中文PDF文档

1) 修改Doxygen配置文件  

To generate a PDF file, you should enable output format Latex, set the tag `GENERATE_LATEX` to YES. Also, to improve the quality of the pdf, the tag `PDF_HYPERLINKS` and `USE_PDFLATEX` need to be set to YES. After then, run doxygen, then latex files will be generated in the output directory under the directory `latex`.

如果要排版 **Latex数学公式**，需要手动把需要的包加进来，在Doxygen配置文件中添加 `EXTRA_PACKAGES = {amsmath,amsthm,amssymb}`，最终  

```ini
GENERATE_LATEX         = YES
EXTRA_PACKAGES         = {amsmath,amsthm,amssymb}
LATEX_TIMESTAMP        = YES
USE_PDFLATEX           = YES
PDF_HYPERLINKS         = YES
```

2) 修改 **refman.tex**  

用文本编辑器打开docxygen生成的latex目录中的refman.tex，将 `\begin{document}` 替换为

```tex
\usepackage{CJKutf8}
\begin{document}
\begin{CJK}{UTF8}{gbsn}
```

将`\end{document}`替换为

```tex
\end{CJK}
\end{document}
```

3) Convert Latex to PDF  

在latex目录使用 `make` 命令生成 或者 用 LaTeXWorks 等工具生成

## JavaDoc
