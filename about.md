---
layout: page
title: 나에 대해
---

[![github](http://img.shields.io/badge/github-mskims-24292e.svg)](http://github.com/mskims) [![email](http://img.shields.io/badge/email-its@mskim.me-3498db.svg)](mailto:{{site.email}})

김민석, 대한민국의 소프트웨어 개발자입니다. 배우는 것이 즐거운 개발자중 한명입니다.

# 경력

**[@리디북스](http://ridibooks.com) `2017.06 ~ 현재`**

- 사용자 로그 수집 파이프라인 구축
- 도서 추천 서비스 개발
- 인프라 마이그레이션

**[@번개장터](http://m.bunjang.co.kr) `2016.11 ~ 2017.06`**

- 120만 MAU 트래픽 경험
- [핫딜 시스템](http://m.bunjang.co.kr/bundeal/66237597) 개발
- [신용거래 시스템](http://bunjang1.blog.me/220924697354) 개발

# 학력

@서울디지텍고등학교 `2014.02 ~ 2017.02`

- 웹개발 동아리 `WebSkills` 회장

# 기술

## 클라이언트

최신 기술을 활용하여 프로덕션 레벨의 SPA 프로젝트를 관리할 수 있습니다. 전통 스택의 프로젝트 또한 개발할 수 있습니다.

- Javascript (ES5+)
  - react, redux
  - electron
- HTML/CSS

## 서버

VPC 구축부터 시작하여 서비스 배포까지 직접 진행할 수 있습니다. 다양한 프레임 워크를 활용하여 API를 구성할 수 있습니다.

- Python
  - django, DRF
- Node.js
  - express, sequelize
- Database
  - RDB, NoSQL
- AWS, Azure

## 기타

- Git
- Docker
- Terraform
- Asana, Slack, Notion


# 사내 프로젝트

로그 수집 파이프라인 [@리디북스](http://ridibooks.com)

- 웹 사이트에서 일어나는 사용자의 각종 행동 로그를 수집하는 기능을 개발했습니다.
  - [github.com/ridi/event-tracker](https://github.com/ridi/event-tracker)
- 수집한 로그를 각종 데이터 웨어하우스에 적재하는 파이프라인을 구축했습니다.
- 기술: TypeScript, AWS Lambda, Kafka, Logstash, HDFS

도서 추천 서비스 [@리디북스](http://ridibooks.com)

- 사용자가 흥미를 가질만한 도서를 추천하는 서비스입니다. 백엔드 개발에 참여했습니다.
- 직접 개발한 오픈소스 인증 라이브러리를 사용했습니다.
  - [github.com/ridi/django-jwt](https://github.com/ridi/django-jwt)
- 기술: Django, HBase, HDFS, Kafka, Logstash

배포 자동화 [@리디북스](http://ridibooks.com)

- 기술: Jenkins, CodeDeploy, Terraform

인프라 마이그레이션 [@리디북스](http://ridibooks.com)

- 팀 내 온프레미스 인프라를 AWS로 이전했습니다.

B2C 핫딜 서비스 **번개딜** [@번개장터](http://m.bunjang.co.kr)

- 기획
  - 초기 기획에 적극적으로 참여하여 의견을 제시했습니다.
- 프론트엔드 개발
  - 서비스 배포를 빠르게 할 수 있도록, 앱 내 웹뷰를 통해 서빙했습니다.
  - 디바이스마다 자바스크립트 엔진이 달랐기 때문에, 호환성을 신중히 고려하여 개발했습니다.
  - 기술: Django, Javascript, HTML/CSS
- 백엔드 개발
  - 서비스에 필요한 테이블 스키마를 설계했습니다.
  - 상품 조회, 주문서 작성, 결제 API를 개발했습니다.
  - 택배사 API와 연계하여 주문의 배송 상태를 자동으로 업데이트하는 배치를 개발했습니다.
  - 기술: Flask
- 관리자 대시보드 개발
  - 상품 정보와 주문/배송을 관리하는 대시보드를 개발했습니다.

# 개인 프로젝트

notion-ga

- notion.so 페이지의 페이지 뷰를 추적하기 위해 만든 프로젝트입니다.
- notion 페이지의 페이지 뷰 통계를 Google Analytics에서 확인할 수 있습니다.
- [github.com/mskims/notion-ga](https://github.com/mskims/notion-ga)
- [블로그 글](http://blog.mskim.me/posts/google-analytics-with-notion-so/)

OS X용 음악 플레이어

- `지니` 서비스가 네이티브 플레이어를 제공하지 않아 직접 개발하였습니다. electron을 사용했습니다.
- [github.com/mskims/genie-music-player](https://github.com/mskims/genie-music-player)

redux-saga 문서 번역

- 영문으로 된 redux-saga 문서를 국문으로 번역했습니다.
- [mskims.github.io/redux-saga-in-korean](https://mskims.github.io/redux-saga-in-korean)

d-coin

- 고교 재학시절, 학우간 빈번한 현금 거래에서 발생하던 사고와 갈등을 방지하기 위해, `d-coin`이라는 현금 대체 서비스를 운영했습니다.
- 거래내역 확인, 송금, 대출, 대출내역 확인, 유저 인증 및 토큰 발급이 가능합니다
- [github.com/mskims/dcoin-API](https://github.com/mskims/dcoin-API)

디지텍위키

- 고교 재학시절, 학우간 정보 공유 및 친목 도모를 위해 `디지텍위키`라는 위키피디아 서비스를 운영했습니다.
- 마크다운 엔진, 위키 시스템을 개발했습니다.
- 많은 트래픽을 처리하는 경험을 얻었습니다.
- [github.com/mskims/digitech-wiki](https://github.com/mskims/digitech-wiki)

모의투자 게임

- 각종 뉴스와 이벤트를 분석하며 실시간으로 투자할수 있는 게임입니다.
- 직접 제작한 [차트 라이브러리](https://github.com/mskims/chart24.js)를 사용했습니다.
- [github.com/mskims/colosseum](https://github.com/mskims/colosseum)

# 커뮤니티 활동

- [AWS Summit Seoul 2019](https://aws.amazon.com/ko/events/summits/seoul/)
- [파이콘 한국 2018](https://www.pycon.kr/2018/)
- [AWS Summit Seoul 2018](https://aws.amazon.com/ko/summits/seoul/agenda/)
- [Korea DevOps Meetup '18](http://meetup.devopskorea.com)
- [GDG DevFest Seoul 2017](https://devfest17-seoul.firebaseapp.com/)
- [DEVIEW 2017](https://deview.kr/2017)
- 제 4회 파이썬 격월 세미나
- React Korea & JSDev.KR The 2nd Meetup
- [AWS Summit Seoul 2017](https://www.awssummit.kr/agenda.html)
- [GDG DevFest Seoul 2016](https://festi.kr/festi/gdg-korea-2016-devfest-seoul/)


[github-profile]: https://github.com/mskims
[linkedin-profile]: http://linkedin.com/in/ohwhos
