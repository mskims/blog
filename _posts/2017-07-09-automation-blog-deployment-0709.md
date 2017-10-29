---
layout: post
title: "블로그 배포 자동화"
tags: [travis]

---

## Travis

배포가 필요한 제 프로젝트에 CI 서비스중 하나인 [travis](http://travis-ci.org) 를 도입했습니다. 퍼블릭 저장소들에게는 무료로 제공하고 있으니 써보시면 좋을거 같습니다.

블로그 글을 새로 올리거나 수정을 할 때 마크다운으로 작성해서 커밋만 하면 자동으로 번들링해서 배포하게 설정해놓았습니다. 편하네요 ㅎ.ㅎ



아래는 이 블로그 저장소의 `.travis.yml` 파일입니다.

```yml
sudo: false
language: ruby
rvm: 2.2.1

cache:
  bundler: true
  directories:
    - bower_components
    - node_modules

install:
  - ./bin/setup

script: bundle exec jekyll build

deploy:
  provider: script
  script: ./bin/deploy
  skip_cleanup: true
```

