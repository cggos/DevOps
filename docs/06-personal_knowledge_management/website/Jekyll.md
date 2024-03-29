# Jekyll

* [Jekyll](https://jekyllrb.com/) is a blog-aware static site generator in Ruby
* [Jekyll 中文网](https://www.jekyll.com.cn/)
* [github上利用jekyll搭建自己的blog的操作顺序？](https://www.zhihu.com/question/30018945?sort=created)

---

## Jekyll Themes

- http://jekyllthemes.org/
- https://jekyllthemes.io/
- https://github.com/le4ker/personal-jekyll-theme

## Install & Config on Ubuntu

* Install all prerequisites (https://jekyllrb.com/docs/installation/ubuntu/)
  ```sh
  sudo apt-get install ruby-full build-essential zlib1g-dev

  echo '# Install Ruby Gems to ~/tools/gems' >> ~/.bashrc
  echo 'export GEM_HOME="$HOME/tools/gems"' >> ~/.bashrc
  echo 'export PATH="$HOME/tools/gems/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
  ```

* Ruby 国内镜像源 (https://blog.hyperzsb.tech/ruby-mirror-source/)
  ```sh
  gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
  gem sources --clear-all
  gem sources --update
  gem sources -l
  ```

* Install the jekyll and bundler gems
  ```sh
  gem install jekyll bundler
  ```

* generate or update **Gemfile.lock**
  ```sh
  # delete Gemfile.lock
  bundle install
  ```

* run in your project dir: 
  ```sh
  jekyll serve --no-watch
  # or
  bundle exec jekyll serve --no-watch
  ```

## HOW TO RELEASE

### Preparation

- `assets/css/main.scss` use configurable skin

- update `CHANGELOG.md`

- update version (`jekyll-text-theme.gemspec`, `package.json`, `_includes/scripts/variables.html`)

### Publishing

- run `npm run gem-build` to build gem
- run `npm run gem-push` to publish gem to rubygems.org
- run `git add . && git commit -m  "release: vx.x.x"` to make a release commit
- run `git tag vx.x.x` to add a tag
- run `git push && git push origin vx.x.x` to push
- edit release on github.com