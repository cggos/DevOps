# Use


---

## CLI

```sh
export http_proxy=socks5://127.0.0.1:1080
export https_proxy=$http_proxy
```

## Browser

* [SwitchyOmega](https://proxy-switchyomega.com/)
    - Chrome 和 Firefox 浏览器上的代理扩展程序，可以轻松快捷的管理和切换多个代理设置

### Chrome

* CLI
  ```sh
  google-chrome-stable --proxy-server="socks5://127.0.0.1:1080"
  ```

* Extentions
    - SwitchyOmega

## Git 

```sh
git config --global http.proxy 'socks5://127.0.0.1:1080'

git config --global http.proxy 'http://127.0.0.1:58591'

git config --global --unset http.proxy
```
