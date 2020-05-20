# Diagrams

* [如何在论文中画出漂亮的插图？](https://www.zhihu.com/question/21664179)
* https://mermaidjs.github.io/
* xkcd styled chart
  - [xkcd](https://xkcd.com/): A webcomic of romance, sarcasm, math, and language.
  - [xkcd styled chart lib](https://github.com/timqian/chart.xkcd)

-----

[TOC]

# Creating Graphics Programmatically

* [Asymptote: The Vector Graphics Language](http://asymptote.sourceforge.net/)

## [Graphviz](http://www.graphviz.org/) - Graph Visualization Software
* [GraphViz Pocket Reference](https://graphs.grevian.org/)
* [GraphViz User Guide](http://graphviz.readthedocs.io/en/stable/manual.html)

## Python matplotlib

* [Daft](https://docs.daft-pgm.org/) is a Python package that uses matplotlib to render pixel-perfect probabilistic graphical models for publication in a journal or on the internet.

## TeX with Math Graphics

* [jPicEdt](http://jpicedt.sourceforge.net/site/index.php)
* [The Ipe extensible drawing editor](http://ipe.otfried.org/)
* [MetaPost (TUG)](https://tug.org/metapost.html)

### TikZ & PGF

* [Latex--TikZ和PGF--高级文本绘图，思维绘图，想到--得到！](https://www.cnblogs.com/tsingke/p/6649800.html)

* [TikZ and PGF](http://www.texample.net/tikz/) are TeX packages for creating graphics programmatically

* [TikzEdt](http://www.tikzedt.org/) is a combined WYSIWYG/text editor designed for editing Tikz code

* [matlab2tikz/matlab2tikz](https://github.com/matlab2tikz/matlab2tikz): converts MATLAB®/Octave figures to TikZ/pgfplots figures for smooth integration into LaTeX

* [tikz-bayesnet](https://github.com/jluttine/tikz-bayesnet): TikZ library for drawing Bayesian networks, graphical models and (directed) factor graphs in LaTeX.

* [GeoGebra](https://www.geogebra.org/): 可以方便的将绘制的各种平面函数图形直接导出为Tikz格式的latex文件

* with **Inkscape**
  - [svg2tikz](https://github.com/kjellmf/svg2tikz): a set of tools for converting SVG graphics to TikZ/PGF code
  - [TexText](https://textext.github.io/textext/): Re-editable LaTeX graphics for Inkscape

## Data Analysis & Graphing

* [QtiPlot](https://www.qtiplot.com/) is a cross platform data analysis and scientific visualisation solution
* [OriginLab](https://www.originlab.com/) - Data Analysis and Graphing Software
* [D3.js](https://d3js.org/) is a JavaScript library for manipulating documents based on data
* [Circos](http://circos.ca/) is a software package for visualizing data and information

### gnuplot

* [gnuplot homepage](http://www.gnuplot.info/)
* [gnuplot 让您的数据可视化](https://www.ibm.com/developerworks/cn/linux/l-gnuplot/)

# Diagram Tools

* [Diagram Designer](http://logicnet.dk/DiagramDesigner/): Simple vector graphics editor for creating flowcharts, UML class diagrams, illustrations and slide shows.
* [Dia Diagram Editor](http://dia-installer.de/) is a program to draw structured diagrams.
* [Xfig](http://mcj.sourceforge.net/) is an interactive drawing tool which runs under X Window System Version 11 Release 4 (X11R4) or later, on most UNIX-compatible platforms, and e.g. under Darwin on the MacIntosh and any X server under Microsoft Windows. It is freeware, and can be downloaded freely
* [Edraw](https://www.edrawsoft.com/): Creating flow chart, mind map, org charts, network diagrams and floor plans with rich gallery of examples and templates

## Inkscape

[Inkscape](https://inkscape.org/) is a professional vector graphics editor for Windows, Mac OS X and Linux. It's free and open source.

* [InkscapeForum](http://www.inkscapeforum.com/)
* extensions
  - [Inkscape Table Support](https://sourceforge.net/projects/inkscape-tables/)

## Online Tools
* [ProcessOn](https://www.processon.com/) 支持流程图、思维导图、原型图、UML、网络拓扑图、组织结构图等
* [draw.io](https://www.draw.io/)
* [Draw Anywhere](http://www.drawanywhere.com/): Create diagrams online. No download, no-install!
* [WebSequenceDiagrams](https://www.websequencediagrams.com/)


# 甘特图(Gantt Chart)


# 思维导图(Mind Map)

* [15款最好用的思维导图（心智图 ）工具](http://www.cnblogs.com/lhb25/p/15-best-mind-mapping-tools-designers.html)

## MindManager
http://www.mindmanager.cn/

## XMind
[XMind](https://www.xmind.net/), a full-featured mind mapping and brainstorming tool, designed to generate ideas, inspire creativity, brings you efficiency both in work and life. Tens of million people love it.

## FreeMind
[FreeMind](http://freemind.sourceforge.net/wiki/index.php/Main_Page) is a premier free mind-mapping software written in Java

* [Free Ur Mind-推荐使用FreeMind工具](https://blog.csdn.net/qq272803220/article/details/7199728)

* 解决 Freemind 中文字体乱码
  由于 Freemind 要应用到 Java 运行时环境，显示中文字体乱码是由于 JRE 的字体造成的，所以更改 JRE 的字体即可。找一个可用于中文显示的字体，比如： wqy 字体，这里采用增黑。  
  确认字体已经安装于系统，我的系统增黑字体安装于：
  ```
  /usr/share/fonts/truetype/wqy/wqy-zenhei.ttf
  ```
  找到 JRE 的字体目录，位于：
  ```
  /usr/lib/jvm/java-6-sun/jre/lib/fonts/
  ```
  创建字体目录：
  ```
  cd /usr/lib/jvm/java-6-sun/jre/lib/fonts/
  sudo mkdir fallback
  sudo ln -s /usr/share/fonts/truetype/wqy/wqy-zenhei.ttf wqy-zenhei.ttf
  sudo mkfontdir
  sudo mkfontscale
  ```
  重启 Freemind 即可

## iMindMap
https://imindmap.com/zh-cn/

## Online
* [百度脑图](http://naotu.baidu.com)
* [极速灵感](http://jsmind.sinaapp.com/)
* [MyMind](http://my-mind.github.io/)
