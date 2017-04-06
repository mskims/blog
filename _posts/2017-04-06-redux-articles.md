---
layout: post
title: "JQuery 에서 Redux 까지"
tags: [ES6, JQuery, React, Redux]
---

> 이 글은 자바스크립트 전문가가 작성한 글이 아니므로 잘못된 내용이나 어색한 내용이 있으면 지적 부탁드립니다.
 
# 소개
평소에 자바스크립트 쪽은 `const` 는 둘째 치고 주고 주로 순수 `ES5`와 제이쿼리를 써왔는데, 새로운 프로젝트 스택이 `React` 로 정해지면서 공부를 시작했다.
  
# ES6
`React` 개발 환경으로 세팅하면서 처음 마주쳤던 문제가, 처음보는 문법들이였다, 

변수 선언부터 Object destructing 까지, 정말 많은 문법을 배웠다.

ES6 이상의 문법은 아직 모든 브라우저가 지원하지 않기 때문에 `Babel` 과 같은 트랜스파일러를 사용하길 바란다.

> Webpack 을 사용하면 편리하게 컴파일 할 수 있다.

#### 참고 사이트
* http://es6-features.org/

# React
React 는 현재 직장 입사할 당시 코딩테스트에서 써봤기 때문에 어느정도 개념은 있어 자료를 찾거나 문서를 읽을때 수월했다.

가상 DOM을 사용하기에 퍼포먼스 면에서 장점이 있고, Props 와 State 에 의존하면서 돔을 변경하기 때문에 기존 제이쿼리의 스파게티ed 라인이 만들어지는것을 어느정도 방지할 수 있다.  

#### 참고 사이트
* https://facebook.github.io/react/
* http://blog.coderifleman.com/2015/06/23/learning-react-1/

# Redux
`Redux` 는 `flux` 라는 아키텍쳐에 기반한 단방향 데이터 흐름을 활용한...