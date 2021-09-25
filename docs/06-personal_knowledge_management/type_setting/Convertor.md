# Convertor

-----

[TOC]

## Pandoc

If you need to convert files from one markup format into another, [pandoc](http://pandoc.org/) is your swiss-army knife.  

* Markdown to PDF  

```sh
pandoc -N -s --toc --smart --latex-engine=xelatex \
  -V mainfont='WenQuanYi Micro Hei' -V geometry:margin=1in \
  note.md  -o output.pdf
```

* Ubuntu上怎么把MS的Word docx文档转为LaTeX

```sh
pandoc -s a.docx --extract-media ./ -o ./b.tex
```

## Docutils

[Docutils](http://docutils.sourceforge.net/): an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.

## Dos2Unix/Unix2Dos

[Dos2Unix / Unix2Dos](https://waterlan.home.xs4all.nl/dos2unix.html) - Text file format converters

## PDF.js

[PDF.js](https://github.com/mozilla/pdf.js) is a Portable Document Format (PDF) viewer that is built with HTML5.

## wk\<html\>toPDF

[wkhtmltopdf](https://wkhtmltopdf.org/) and wkhtmltoimage are open source (LGPLv3) command line tools to render HTML into PDF and various image formats using the Qt WebKit rendering engine. These run entirely "headless" and do not require a display or display service. There is also a C library, if you're into that kind of thing.

## Other PDF tools

* [PDF to jpg](https://pdf2jpg.net/)

* [Markdown to PDF](http://www.markdowntopdf.com/)

* [Markdown to Ebook: html、mobi、epub、pdf、rtf](https://github.com/phodal/ebook-boilerplate)

* [PDF Generation On The Web](https://fraserxu.me/2015/08/20/pdf-generation-on-the-web/)

* [PDF Buddy](https://www.pdfbuddy.com/)
