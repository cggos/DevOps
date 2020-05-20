# Convertor

## Doxygen
[Doxygen](http://www.stack.nl/~dimitri/doxygen) is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.

### 使用Doxygen生成中文PDF文档
1) 修改Doxygen配置文件  
To generate a PDF file, you should enable output format Latex, set the tag `GENERATE_LATEX` to YES. Also, to improve the quality of the pdf, the tag  `PDF_HYPERLINKS` and  `USE_PDFLATEX` need to be set to YES. After then, run doxygen, then latex files will be generated in the output directory under the directory “latex”.如果要排版**Latex数学公式**，需要手动把需要的包加进来，在Doxygen配置文件中添加`EXTRA_PACKAGES = {amsmath,amsthm,amssymb}`.  
最终  
```
GENERATE_LATEX         = YES
EXTRA_PACKAGES         = {amsmath,amsthm,amssymb}
LATEX_TIMESTAMP        = YES
USE_PDFLATEX           = YES
PDF_HYPERLINKS         = YES
```
2) 修改**refman.tex**  
用文本编辑器打开docxygen生成的latex目录中的refman.tex,   
将`\begin{document}`替换为
```
\usepackage{CJKutf8}
\begin{document}
\begin{CJK}{UTF8}{gbsn}
```
将`\end{document}`替换为
```
\end{CJK}
\end{document}
```

3) Convert Latex to PDF  
在latex目录使用 `make` 命令生成 或者 用 LaTeXWorks 等工具生成

## JavaDoc

## MkDocs
Project documentation with Markdown.  
[MkDocs](http://www.mkdocs.org/) is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration file.

## kramdown
[kramdown](https://kramdown.gettalong.org/index.html) (sic, not Kramdown or KramDown, just kramdown) is a free MIT-licensed **Ruby library for parsing and converting a superset of Markdown**.

## Pandoc
If you need to convert files from one markup format into another, [pandoc](http://pandoc.org/) is your swiss-army knife.  

* Markdown to PDF  
```
pandoc -N -s --toc --smart --latex-engine=xelatex -V mainfont='WenQuanYi Micro Hei' -V geometry:margin=1in note.md  -o output.pdf
```

## wk\<html\>toPDF
[wkhtmltopdf](https://wkhtmltopdf.org/) and wkhtmltoimage are open source (LGPLv3) command line tools to render HTML into PDF and various image formats using the Qt WebKit rendering engine. These run entirely "headless" and do not require a display or display service. There is also a C library, if you're into that kind of thing.

## Other PDF tools
* [PDF to jpg](https://pdf2jpg.net/)
* [Markdown to PDF](http://www.markdowntopdf.com/)
* [Markdown to Ebook: html、mobi、epub、pdf、rtf](https://github.com/phodal/ebook-boilerplate)
* [PDF Generation On The Web](https://fraserxu.me/2015/08/20/pdf-generation-on-the-web/)
* [PDF Buddy](https://www.pdfbuddy.com/)

**Atom Markdown to PDF**: Atom有一个Markdown Preview的插件，Markdown文件下按ctrl+shit+m就可以预览Markdown，然后右键生成的预览文件可以保存为html文件，再用chrome打开这个html文件，右键Print里面转换成pdf

## Dos2Unix/Unix2Dos
* [link](https://waterlan.home.xs4all.nl/dos2unix.html)
