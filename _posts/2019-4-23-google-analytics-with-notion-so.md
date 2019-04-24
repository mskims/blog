---
layout: post
title: "노션에서 구글 애널리틱스 사용하기"
date: 2019-04-23 19:30:00 +0900
categories: productivity
---

# TL;DR

- [노션 페이지에서 구글 애널리틱스를 사용할 수 있도록 도와주는 프록시 서버](https://github.com/mskims/notion-ga)를 만들었습니다.
- 페이지 조회 이벤트를 추적할 수 있습니다.

노션에는 문서들을 웹 사이트나 블로그처럼 사용할 수 있는 'Public Access' 옵션이 있습니다. 'Public Access' 옵션을 활성화하면 사용자를 따로 워크 스페이스나 개별 문서에 초대하지 않아도 모든 사용자가 자유롭게 문서를 열람할 수 있습니다.

'Public Access' 옵션을 활용하면 노션의 강력한 기능들을 블로깅에 활용할 수 있기 때문에 많은 사용자, 기업들이 노션을 블로그로 사용하고 있습니다. 하지만 이런 블로그들은 노션이라는 한정된 플랫폼에 기반하기 때문에, 몇가지 문제가 발생할 수 있습니다.

그중 가장 큰 문제는 바로 **사용자 추적이 불가능**하다는 점입니다. 네이버 블로그나 브런치같은 블로그 서비스들은 자체적인 사용자 추적 서비스를 제공합니다. 기본적인 페이지 조회수, 방문자의 인구 통계등 자세한 통계를 제공합니다. 하지만 노션에는 이런 기능들이 없습니다. 적어도 지금까지는요. 추가좀 해주세요 😁

![](/assets/naver-visitors-stat.png)
*네이버 블로그의 사용자 추적 서비스*

서비스에서 사용자 추적 기능을 제공하지 않거나, 직접 블로그 시스템을 개발하고 있다면 다른 방법을 사용할 수도 있습니다. 구글이나 페이스북에서 제공하는 분석 도구를 적용하면 됩니다. 하지만 노션에서는 이런 분석 도구도 적용할 수 없습니다. [구글 애널리틱스](https://marketingplatform.google.com/about/analytics/)나 [페이스북 픽셀](https://www.facebook.com/business/learn/facebook-ads-pixel)같은 대표적인 분석 도구들은 [자바 스크립트](https://en.wikipedia.org/wiki/JavaScript)라는 언어를 기반으로 작동하는데, 노션에서는 사용자가 자바 스크립트를 실행할 방법이 없기 때문입니다.

이것도 안되고 저것도 안되면 정녕 노션에서는 사용자를 추적할 수 있는 방법이 없는걸까요? 정말요?

다행히 노션에서도 여러가지 방법으로 사용자를 추적할 수 있습니다. 리다이렉션을 통한 추적과 이미지를 통한 추적 방법이 있는데요. 지금부터 천천히 소개 드리겠습니다.

## 1. 리다이렉션

첫 번째 방법은 [URL 리다이렉션](https://ko.wikipedia.org/wiki/URL_리다이렉션) 서비스의 일종인 [bit.ly](http://bit.ly)를 활용한 방법입니다. 노션 페이지의 URL을 bit.ly/OOOO 으로 연결시킨 후에, 사용자를 연결된 URL로 접근하도록 유도하는 방식입니다. 자세히 정리해보면 다음과 같이 진행됩니다.

1. 노션 페이지의 URL을 bit.ly에 연결시킨다. (notion.so/OOOO → bit.ly/OOOO)
2. 연결된 URL(bit.ly/OOOO)를 사용자들에게 공유한다.
3. 사용자가 bit.ly/OOOO으로 접근하면, bit.ly 서버는 URL을 notion.so/OOOO 으로 변경 후 이동시킨다.
4. bit.ly 서버는 URL을 이동시키는 과정에서 사용자 추적 데이터를 남기고, 통계를 제공한다.

![](/assets/bitly-visitors-stat.png)
*[bit.ly](http://bit.ly)의 사용자 추적 서비스*

이 방법은 사용자 추적을 간단히 구현할 수 있다는 장점이 있지만, 사용자가 [bit.ly](http://bit.ly) URL 외의 다른 URL으로 페이지에 접근하는 경우는 추적하지 못한다는 큰 문제가 있습니다.

## 2. 구글 애널리틱스 - Measurement Protocol

> 구글 애널리틱스 못 쓴다면서요!

죄송합니다. 사실 사용할 수 있습니다. [Measurement Protocol](https://developers.google.com/analytics/devguides/collection/protocol/v1/)을 이용한다면요.

구글 애널리틱스에 이벤트를 보내는 방법은 두 가지가 있습니다. 첫 번째는 모두가 익히 알고 있는 자바 스크립트를 이용한 방법입니다. 하지만 노션에서는 자바 스크립트를 사용할 수 없기 때문에 사용할 수 없습니다. 아쉽지만 두 번째 방법으로 넘어가도록 하죠.

두 번째 방법은 구글 애널리틱스의 **Measurement Protocol**을 이용한 방법입니다. Measurement Protocol은 자바 스크립트를 통하지 않고도 구글 애널리틱스에 이벤트를 보낼 수 있도록 만든 일종의 통신 규약입니다. 주로 자바 스크립트를 사용할 수 없는 환경에서 사용합니다. 노션에서 사용하기에 적절한 방법이죠.

방법은 간단합니다. Measurement Protocol가 정의한 규약에 따라서 HTTP 요청을 구글 애널리틱스 서버로 보내기만 하면 됩니다. 그걸 노션에서 어떻게 하냐구요? 노션 페이지에 Embed 이미지만 넣으면 됩니다. 그 외에도 할게 많긴 한데, 제가 미리 만들어 놓았으니 걱정하지 않아도 됩니다.

1. URL에 트래킹 ID, 도메인, 페이지 경로를 추가하여 URL을 생성합니다.
   - https://notion-ga.ohwhos.now.sh/collect?tid={트래킹 ID}&host={도메인}&page={경로}
   - (예) https://notion-ga.ohwhos.now.sh/collect?tid=UA-00000000-1&host=mskim.me&page=/careers/data-engineer
   - 트래킹 ID를 모르겠다면 [이 문서](https://support.google.com/analytics/answer/7476135?hl=ko#trackingID)를 참고하세요.
   - 더 자세한 내용은 [이 문서](https://github.com/mskims/notion-ga#parameter-reference)를 참고하세요.
2. 생성한 URL을 Embed 이미지에 입력하고, 추적이 필요한 노션 페이지에 삽입합니다.

![](/assets/notion-ga-preview.gif)

끝입니다. 거창한 기반 지식을 알아야 할 필요도 없고, [bit.ly](http://bit.ly) 같은 외부 서비스를 활용할 필요도 없습니다. 그저 URL을 Embed 이미지로 삽입하면 됩니다.

어떻게 이런 방법이 가능할까요? 이미지 하나만 추가했을 뿐 인데 어떻게 구글 애널리틱스에 데이터가 전송될까요? 그건 [notion-ga](https://github.com/mskims/notion-ga)라는 프록시 서버가 이미지 조회 요청을 구글 애널리틱스에 전달하고 있기 때문입니다.

## notion-ga

[https://github.com/mskims/notion-ga](https://github.com/mskims/notion-ga)

notion-ga는 제가 작성한 간단한 프록시 서버입니다. 사용자의 이미지 조회 요청을 Measurement Protocol에 부합하도록 변환하고, 변환된 요청을 구글 애널리틱스에 전달하는 역할을 합니다. 구현이 어떻게 되었는지 궁금하신 분들은 위의 저장소를 확인하시면 됩니다. 구경 하시고 스타도 찍어 주시고.. MIT 라이센스니 이것 저것 다 해보셔도 됩니다.

## 마치며

이렇게 노션 페이지에서 구글 애널리틱스를 사용하여 사용자를 추적하는 방법을 정리해 봤습니다. 노션을 애용하는 한 개발자로서, 제가 공유한 지식이 많은 분들께 도움이 되었으면 좋겠습니다. 읽어주셔서 감사합니다.

피드백은 이메일(its@mskim.me)로 부탁드립니다.
