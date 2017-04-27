---
layout: post
title: "ES6 destructuring assignment"
tags: [javascript, es6]
---

ES6 에는 재미있는 기능이 참 많습니다.

어떻게 이런게 될까? 하고 생각이 들기도 하지만 쓰다보면 정말 편합니다.

대표적으로 `destructuring assignment` (해체 선언?) 이 있습니다.

nested 한 오브젝트를 다뤄야 할때 한번에 다룰 수 있어서 참 좋습니다.

**argument 를 전달할때도 효율적입니다.**

```js
// 기본값도 설정할 수 있습니다.
const foo = ({ bar, zoo, what='what?' }) => {
    console.log(bar, zoo, what); // barr~, zoo~, what?
}

foo({ bar: 'bar~', zoo: 'zoo~' });
```

**배열에도 사용할 수 있습니다.**
```js
const foo = [1, 2, 3];

const bar = [0, ...foo];
```

**Deep Copy 의 좋은 방법이기도 합니다**
```js
const previousOne = { key: 'still can you see me?' };

const newOne = { ...previousOne };

newOne.key = 'Now you cant!';

console.log(previousOne.key); // still can you see me?
```

**복잡한 예시**

```js
const {
  parentKey: { childKey, secondChildKey }
} = {
  parentKey: {
    childKey: 'this will be shown',
    secondChildKey: 'this too'
  }
}

console.log(childKey);  // 'this will be shown'
console.log(secondChildKey);  // 'this too'
```
