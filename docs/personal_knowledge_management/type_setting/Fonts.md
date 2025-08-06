# Fonts

* [Ubuntu字体](http://wiki.ubuntu.org.cn/%E5%AD%97%E4%BD%93)
* [font-spider](https://github.com/aui/font-spider)
* [Free Fonts Search and Download](https://www.free-fonts.com/)

---

## App

### Ubuntu下解决WPS字体缺失问题 [^1]

* 获取字体 `wps_symbol_fonts.zip`

* 将字体解压到文件夹 `/usr/share/fonts` 或 `~/.local/share/fonts`

* 生成字体的索引信息
  ```sh
  sudo mkfontscale
  sudo mkfontdir
  ```

* 更新字体缓存
  ```sh
  sudo fc-cache
  ```

[^1]: https://mxy493.xyz/2019040840601/
