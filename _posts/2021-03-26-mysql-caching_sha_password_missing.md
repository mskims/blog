---
layout: post
title: "MySQL: caching_sha2_password 삽질기"
date: 2021-03-26 23:00:00 +0900
categories: develop
---

python3.7, sqlalchemy, mysqlclient 환경. 로컬 및 원격 서버에선 문제 없이 돌아가던 서비스가 도커 가상 환경에서 문제 발생.

```bash
ERROR 2059 (HY000): Authentication plugin 'caching_sha2_password' cannot be loaded:
/usr/lib64/mysql/plugin/caching_sha2_password.so: cannot open shared object file: No such file or directory
```

caching_sha2_password 플러그인의 부재. caching_sha2_password: DB 사용자 비밀번호 해싱 플러그인. MySQL 8.0부터 기본으로 추가됨. 기존 mysql_native_password보다 보안이 강화된 버전.

## 시도 1. 패키지 업데이트

해당 플러그인이 넓게 사용된지 얼마 되지 않았기 때문에, stable linux distribution의 클라이언트에선 지원하지 않을 수 있음. 해당 프로젝트에선 mysqlclient를 사용. mysqlclient는 libmysqlclient-dev패키지를 사용함. (debian / ubuntu)

공식 파이썬 도커 이미지에선 stable debian distribution인 buster, stretch를 사용함. 그러나 해당 배포판의 libmysqlclient-dev 패키지는 caching_sha2_password 플러그인을 지원하지 않기때문에 오류 발생. 정확히는 libmysqlclient-dev 패키지가 의존하고있는 패키지가 지원하지 않음 ([mariadb-10.5](https://packages.debian.org/buster/libmariadb3)). 2020년 9월이 되서야 플러그인 지원 업데이트가 되었고 bullseye 배포판에서부터 해당 버전이 포함됨.

```
 -- Otto Kekäläinen <otto@debian.org>  Tue, 06 Oct 2020 14:44:39 +0300

mariadb-10.5 (1:10.5.5-1) unstable; urgency=medium

  * New upstream version 10.5.5 (Closes: #968895)
    - Include caching_sha2_password.so plugin for libmariadb3 (Closes: #962597)
```

하지만 bullseye 배포판은 아직 unstable이라 공식 파이썬 도커 이미지에선 사용할 수 없음. (공식 파이썬 도커 이미지는 debian 배포판별로 태그를 제공함, 3.9-buster, 3.7.10-stretch 등)

apt 커맨드 수도 없이 때려보며 디버깅하다 포기

## 시도 2. 클라이언트를 바꿔보자

클라이언트를 바꿔보자. 해당 플러그인을 지원하는 PyMySQL을 사용하기로 함. 클라이언트를 바꿔보니 거짓말처럼 너무 잘 됨. 그냥 사용하려고 했으나 퍼포먼스 관련 문제로 사용하지 못함. PyMySQL은 순수 파이썬으로 구현됐기 때문에 부분적으로 C로 작성된 mysqlclient보다 훨씬 느림. [벤치마크](https://stackoverflow.com/a/46396881/6007308)에 의하면 최대 10배 느림. 포기

## 시도 3. 다른 리눅스 배포판을 써보자

또 다른 방법, 다른 리눅스 배포판을 써보자. 파이썬 공식 도커 이미지에서 제공하는 alpine linux based image 사용. 그러나 C 컴파일링 관련 이슈덕분에 파이썬 패키지 설치 시간이 곱절로 뛰는 문제가 있음. 포기.. [link](https://pythonspeed.com/articles/alpine-docker-python/)

## 시도 4. 포기하자

이틀에 걸쳐 몇 시간동안 삽질하니까 도커 쓰기 싫어짐. 포기하고 mysql_native_password로 바꾸자고 생각했으나.. 기적같이 해결

## 해결

몇 시간 끙끙 앓다가 배포판 이미지에 최신 버전 패키지를 강제로 설치해서 해결함. debian bullseye 는 unstable distribution이긴 하지만 전체 이미지를 쓰는게 아니니 괜찮을거라 생각

```docker
FROM python:3.7-buster

RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list.d/bullseye.list \
    && apt-get update -y \
    && apt-get purge default-libmysqlclient-dev -y \
    && apt autoremove -y \
    && apt-get install default-libmysqlclient-dev/bullseye -y
```
