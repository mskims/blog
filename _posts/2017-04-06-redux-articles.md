---
layout: post
title: "JQuery 에서 Redux 까지"
tags: [ES6, JQuery, React, Redux]
---

> 잘못된 내용이나 어색한 내용이 있으면 지적 부탁드립니다.
 
# 소개
평소에 자바스크립트 쪽은 `const` 는 둘째 치고 주고 주로 순수 `ES5`와 제이쿼리를 써왔는데, 새로운 프로젝트 스택이 `React` 로 정해지면서 공부를 시작했다.
  
# ES6
`React` 개발 환경으로 세팅하면서 처음 마주쳤던 문제가, 처음보는 문법들이였다, 

변수 선언부터 Object destructing 까지, 정말 많은 문법을 배웠다.

ES6 이상의 문법은 아직 모든 브라우저가 지원하지 않기 때문에 `Babel` 과 같은 트랜스파일러를 사용하길 바란다.

> Webpack 을 사용하면 편리하게 컴파일 할 수 있다.

#### References
* http://es6-features.org/

# React
React 는 프론트 커뮤니티에서 가장 빠르게 성장하고있는 라이브러리중 하나이다.

## Virtual DOM
React 는 DOM 렌더링에 가상 DOM을 사용한다.

DOM 을 다시 그려야 할 일이 생기면 모든 돔을 다시 그리지 않고 전후 상태를 비교하여 변화가 있는 부분만 렌더링 한다.

꼭 필요한 부분만 다시 렌더링하기 때문에 좋은 퍼포먼스를 보여준다.

## Components
React 는 컴포넌트간 단방향 데이터 흐름을 지향한다.

컴포넌트간 전달되는 Props 와 고유 State 에 의존하는 데이터 흐름을 가지고있는데, 이런 단방향 데이터 흐름은 컴포넌트간 데이터 전달이 명확하기 때문에 전체 앱을 관리하기 수월해진다.

## Why react?
도입 단계에서 리엑트와 Angular 사이에서 고민을 했는데, 결국 React 로 결정 했다.

React는 사실 간단한 View(UI) 라이브러리 이다. 공식 홈페이지를 보면 알수 있듯이 Lifecycle과 디자인 패턴등만 숙지 하면 빠르게 익숙해 질 수 있다.

간단한 만큼 다른 모듈, 라이브러리들을 쉽게 적용하고 시험해볼수 있다, 확장성이 좋다는 말이다.

필자가 느낀 Angular 는 Django 와 같은 완전한 프레임워크 같았다.

자유로운 구조와 확장성을 보장하는 React 와 달리 전체 프로젝트 구조를 제한하는 점이 마음에 들지 않았다.

## Static type check
React 의 특이한 점중 하나가, 리엑트는 정적 타입 체크를 가능하게 해주는 TypeScript 대신 Flow 라는 타입 분석기 사용을 권장한다. [#Post]

(https://discuss.reactjs.org/t/if-typescript-is-so-great-how-come-all-notable-reactjs-projects-use-babel/4887/2)

위 글은 Babel과 Flow팀 멤버가 리엑트 공식 포럼에서 답변한 내용인데, 대충 말하자면 빠르게 변화하는 생태계속에서 개발자들이 타입 체크에 쓰는 시간을 줄이고 타입때문에 커스텀하기 어렵지 않도록 hackable 하게 만들겠다는 이야기 이다.

## Interesting projects
- 모바일 애플리케이션 개발을 가능하게 해주는 [react-native](https://facebook.github.io/react-native)
- VR 웹사이트 개발을 가능하게 하는 [react-vr](https://facebook.github.io/react-vr)

#### References
* [https://facebook.github.io/react/](https://facebook.github.io/react/)
* [http://blog.coderifleman.com/2015/06/23/learning-react-1/](http://blog.coderifleman.com/2015/06/23/learning-react-1/)

# Redux
`Redux` 는 `flux` 라는 아키텍쳐에 기반한 단방향 데이터 흐름을 활용한 상태(State) 저장소 이다.

#### References
* [http://redux.js.org/](http://redux.js.org/)