---
layout: post
title: "[번역] redux-saga 튜토리얼"
date:   2017-04-27 12:00:00 +0900
categories: translation
---

> 이 글은 [공식문서 의 Beginner tutorial](https://redux-saga.js.org/) 을 한국어로 번역한 글입니다.
>
> 전체 문서는 [한국어 번역 문서](https://mskims.github.io/redux-saga-in-korean/) 를 참조해주세요.

# 튜토리얼

## 목적

이 튜토리얼은 redux-saga 를 가능한 쉬운 방법으로 소개할 것 입니다.

튜토리얼을 위해서, 우리는 Redux 저장소에 있는 간단한 카운터 예시를 사용할겁니다.
이 카운터 애플리케이션은 아주 간단하면서, 과도하게 빠지지 않고 redux-sage 의 기본 컨셉들을 설명 하기에 딱입니다.

### 초기 설정

시작하기 전에, [튜토리얼 저장소](https://github.com/redux-saga/redux-saga-beginner-tutorial) 를 클론 하세요.

> 이 튜토리얼의 코드들은 `sagas` 브랜치에 있습니다.

커맨드 라인에서 다음 명령어를 실행하세요:

```sh
$ cd redux-saga-beginner-tutorial
$ npm install
```

애플리케이션을 시작하기 위해서는 다음 명령어를 실행하시면 됩니다:

```sh
$ npm start
```

`증가` 와 `감소` 버튼이 있는 카운터로 아주 간단하게 시작하고, 그후 비동기 호출에 대해서 설명하겠습니다

이상이 없다면, 당신은 `증가` 와 `감소` 버튼과 `Counter: 0` 이라는 메세지를 볼 수 있을것 입니다.

> 만약 이 단계에서 어려움을 겪고계시다면, 고민하지 마시고 [튜토리얼 저장소](https://github.com/redux-saga/redux-saga-beginner-tutorial/issues) 에 에슈를 만들어주세요.


## Hello Sagas!

첫번째 Saga 를 만들어봅시다! 전통을 따라, Saga 버전 'Hello, world' 를 작성해 봅시다.

`sagas.js` 파일을 만드신 후 다음 내용을 적으세요.

```javascript
export function* helloSaga() {
  console.log('Hello Sagas!')
}
```

무서운것이 없습니다, 이건 그냥 평범한 함수일 뿐이에요. (`*`를 제외하면요). 이것이 하는일은 콘솔에 환영 메세지를 적는것밖에 없습니다.

우리의 Saga 를 실행하기 위해서, 몇가지 할 일이 있습니다.

- Sagas 리스트와 함께 Saga 미들웨어를 만드세요. (지금까진 `helloSaga` 오직 하나입니다)
- Saga 미들웨어를 Redux 스토어에 연결하세요.

이제 `main.js` 를 작성해봅시다:

```javascript
// ...
import { createStore, applyMiddleware } from 'redux'
import createSagaMiddleware from 'redux-saga'

// ...
import { helloSaga } from './sagas'

const sagaMiddleware = createSagaMiddleware()
const store = createStore(
  reducer,
  applyMiddleware(sagaMiddleware)
)
sagaMiddleware.run(helloSaga)

const action = type => store.dispatch({type})

// rest unchanged
```

처음에, `./sagas` 모듈에서 가져온 우리의 Saga 를 임포트 합니다. 그리고 나서 `redux-saga` 라이브러리에서 가져온 `createSagaMiddleware` 팩토리 함수를 사용해서 미들웨어를 만들었죠.

`helloSaga` 를 실행하기 전에, 반드시 `applyMiddleware` 를 사용해서 미들웨어를 연결해야 `sagaMiddleware.run(helloSaga)` 를 통해 Saga 를 시작할 수 있습니다..

지금까지 우리의 Saga 는 특별하지 않습니다. 이건 단지 로그 메세지만을 남기고 종료될 뿐입니다.

## 비동기 호출

이제, 오리지널 카운터 데모 가까이 무언가를 추가해봅시다. 비동기 호출을 설명하기 위해 클릭 1초 후 증가되는 또다른 버튼을 추가할겁니다.

먼저, UI 컴포넌트에 `onIncrementAsync` 라는 콜백을 넣을겁니다.

```javascript
const Counter = ({ value, onIncrement, onDecrement, onIncrementAsync }) =>
  <div>
    {' '}
    <button onClick={onIncrementAsync}>
      Increment after 1 second
    </button>
    <hr />
    <div>
      Clicked: {value} times
    </div>
  </div>
```

다음으로, `onIncrementAsync` 를 스토어 액션에 연결해야 합니다.

`main.js` 모듈을 다음과 같이 수정하겠습니다.

```javascript
function render() {
  ReactDOM.render(
    <Counter
      value={store.getState()}
      onIncrement={() => action('INCREMENT')}
      onDecrement={() => action('DECREMENT')}
      onIncrementAsync={() => action('INCREMENT_ASYNC')} />,
    document.getElementById('root')
  )
}
```
명심하세요, redux-thunk 와는 달리 우리의 컴포넌트는 순수 액션 오브젝트만 dispatch 할겁니다.

이제 비동기 호출을 구현하기 위해 또다른 Saga 를 소개해볼까 합니다.

> 각각의 `INCREMENT_ASYNC` 액션에서, 우리는 다음과 같은 작업을 수행할 태스크를 시작하고자 합니다.
> - 1 초를 기다린 후 카운터 증가

다음 코드를 `sagas.js` 모듈에 추가하세요.

```javascript
import { delay } from 'redux-saga'
import { put, takeEvery } from 'redux-saga/effects'

// worker Saga: 비동기 증가 태스크를 수행할겁니다.
export function* incrementAsync() {
  yield delay(1000)
  yield put({ type: 'INCREMENT' })
}

// watcher Saga: 각각의 INCREMENT_ASYNC 에 incrementAsync 태스크를 생성할겁니다.
export function* watchIncrementAsync() {
  yield takeEvery('INCREMENT_ASYNC', incrementAsync)
}
```

설명할 때가 왔군요.

`delay` 라는 유틸리티 함수를 임포트 했는데요, 이 함수는 설정된 시간 이후에 resolve 를 하는 [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) 객체를 리턴합니다. 우리는 이 함수를 제너레이터를 *정지* 하는데 사용할겁니다.

Sagas 는 오브젝트들을 redux-saga 미들웨어에 *yield* 하는 [제너레이터 함수](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*) 로 구현되었습니다. *yield된* 오브젝트들은 미들웨어에 의해 해석되는 명령의 한 종류입니다. Promise 가 미들웨어에 yield 될 때, 미들웨어는 Promise 가 끝날때 까지 Saga 를 일시정지 시킬것 입니다. 위의 예시에서, `incrementAsync` Saga 는 1초 후에 일어날 `delay`의 resolve 에 의해 Promise 가 리턴될때 까지 정지되어있을겁니다.

Promise 가 한번 resolve 되고 나면, 미들웨어는 Saga 를 다시 작동시키면서, 다음 yield 까지 코드를 실행합니다. 이 예제에서 다음 상태는 미들웨어에게 `INCREMENT` 액션을 dispach 하게 알려주는  `put({type: 'INCREMENT'})` 의 결과 객체가 됩니다.

`put` 은 우리가 *이펙트* 라고 부르는 예중 하나입니다. 이펙트는 미들웨어에 의해 수행되는 명령을 담고있는 간단한 자바스크립트 객체입니다. 미들웨어가 Saga 에 의해 yield 된 이펙트를 받을때, Saga 는 이펙트가 수행될때까지 정지되어 있을겁니다.

정리하자면, `incrementAsync` Saga 는 `delay(1000)` 호출에 의해 1초동안 자고있다가, `INCREMENT` 액션을 dispatch 하게 되는것이죠.

다음으로, 우리는 `watchIncrementAsync` 라는 또다른 Saga를 만들었습니다. dispatch된 `INCREMENT_ASYNC` 액션을 바라보고, 매번 `incrementAsync` 를 실행하기 위해 `redux-saga` 패키지가 제공하는 `takeEvery` 헬퍼 함수를 사용했습니다.

이제 두개의 Saga가 있네요, 이제 두 Saga 모두 한번에 실행해야할 필요가 생겼습니다, 이 작업을 하려면, 다른 Saga들을 시작해야할 책임이 있는 `rootSaga` 를 추가해봅시다.

자 이제 여기 코드들을 `sagas.js` 에 추가해보세요.

```javascript
// 모든 Saga들을 한번에 시작하기 위한 하나의 지점입니다.
export default function* rootSaga() {
  yield [
    incrementAsync(),
    watchIncrementAsync()
  ]
}
```

이 Saga는 `helloSaga` Saga 와 `watchIncrementAsync` Saga 가 호출된 결과의 배열을 yield 합니다. 이것은 생선된 두 제너레이터가 병렬로 시작된다는것을 의미하죠. 이제 `sagaMiddleware.run` 를 `main.js` 의 root Saga에 주입할 일만 남았습니다.

```javascript
// ...
import rootSaga from './sagas'

const sagaMiddleware = createSagaMiddleware()
const store = ...
sagaMiddleware.run(rootSaga)

// ...
```

## 테스트

이제 우리의 `incrementAsync` Saga 가 바람직한 태스크를 수행하는지 확실하게 해야겠죠? 테스트를 만들어 봅시다.

`sagas.spec.js` 파일을 만듭시다.

```javascript
import test from 'tape';

import { incrementAsync } from './sagas'

test('incrementAsync Saga test', (assert) => {
  const gen = incrementAsync()

  // now what ?
});
```

`incrementAsync` 는 제너레이터 함수입니다. 이것을 실행하면, 이터레이터 오브젝트를 반환하고, 이터레이터의 `next` 메소드는 다음과 같은 모양을 가진 객체를 돌려줍니다.

```javascript
gen.next() // => { done: boolean, value: any }
```

`value` 필드는 yield 된 표현식을 포함합니다. `yield` 다음 표현식의 결과 같은 것 말이죠.
`done` 필드는 아직 `yield` 표현이 남아있는지, 아니면 제너레이터가 종료되었는지 가리킵니다.


`incrementAsync` 로 예를 들자면, 제너레이터는 두개의 값을 연속으로 yield 합니다.

1. `yield delay(1000)`
2. `yield put({type: 'INCREMENT'})`

그래서 우리가 제너레이터의 next 메소드를 세번 연속하여 부른다면, 다음과 같은 결과값을 얻게 됩니다.

```javascript
gen.next() // => { done: false, value: <result of calling delay(1000)> }
gen.next() // => { done: false, value: <result of calling put({type: 'INCREMENT'})> }
gen.next() // => { done: true, value: undefined }
```

처음 두개 호출은 yield 표현의 결과를 돌려줍니다. 3번째 호출은 더이상 yield 가 없기 때문에 `done` 필드는 true 로 설정되고, `incrementAsync` 제너레이터가 아무것도 리턴하지 않기 때문에 `value` 필드는 `undefined` 로 설정됩니다.

자 이제, `incrementAsync` 안에서 로직을 테스트하기 위해, 돌려받은 제너레이터를 반복하고, 제너레이터에 의해 yield 된 값들을 간단히 체크할겁니다.

```javascript
import test from 'tape';

import { incrementAsync } from './sagas'

test('incrementAsync Saga test', (assert) => {
  const gen = incrementAsync()

  assert.deepEqual(
    gen.next(),
    { done: false, value: ??? },
    'incrementAsync should return a Promise that will resolve after 1 second'
  )
});
```

하지만 Promise 에선 비교연산을 할 수 없는데 어떻게 `delay` 의 리턴값을 테스트 하죠?  만약 `delay` 가 *평범한* 값을 돌려준다면 테스트하기 쉬울텐데요..

`redux-saga` 는 위의 고민을 해결할 방법을 제시하고 있습니다. `incrementAsync` 에서 `delay(1000)` 을 직접적으로 호출하는것 대신, 우린 *간접적으로* 호출할겁니다.

```javascript
// ...
import { delay } from 'redux-saga'
import { put, call, takeEvery } from 'redux-saga/effects'

export function* incrementAsync() {
  // use the call Effect
  yield call(delay, 1000)
  yield put({ type: 'INCREMENT' })
}
```

`yield delay(1000)` 대신 `yield call(delay, 1000)` 를 하고있습니다, 무엇이 달라졌는지 보이시나요?

첫번째 경우에서, `delay(1000)` yield 구문은 `next` 의 호출자로 넘겨지기 전에 실행되고, (여기서 호출자는 미들웨어가 되거나, 제너레이터 함수를 실행하고 리턴된 제너레이터를 넘어 반복하는 테스트코드가 되어야 합니다.)  호출자가 얻게 되는것은 Promise 입니다. 아래 코드를 참고하세요.

두번째 경우에선, `call(delay, 1000)` yield 구문은 `next` 의 호출자에게 넘겨지게 됩니다. `put` 과 유사한 `call` 은 미들웨어에게 주어진 함수와 인자들을 실행하라는 명령을 하는 이펙트를 리턴합니다.
사실, `put` 과 `call` 은 스스로 어떤 dispatch 나 비동기적인 호출을 하지 않습니다. 그들은 단지 순수한 자바스크립트 객체를 돌려줄 뿐입니다.

```javascript
put({type: 'INCREMENT'}) // => { PUT: {type: 'INCREMENT'} }
call(delay, 1000)        // => { CALL: {fn: delay, args: [1000]}}
```

무슨일이 일어날까요? 미들웨어는 각각의 yield 된 이펙트들을 검사한뒤, 어떻게 이펙트를 수행할지 결정합니다. 만약 이펙트의 타입이 `PUT` 이라면, 미들웨어는 스토어에 액션을 dispatch 할것입니다. `CALL` 인 경우엔 주어진 함수를 실행하게 되는것 이고요.

이 이펙트생성과 이펙트 실행의 분리는 제너레이터를 놀랍게도 쉽게 테스트가 가능하도록 만듭니다.

```javascript
import test from 'tape';

import { put, call } from 'redux-saga/effects'
import { delay } from 'redux-saga'
import { incrementAsync } from './sagas'

test('incrementAsync Saga test', (assert) => {
  const gen = incrementAsync()

  assert.deepEqual(
    gen.next().value,
    call(delay, 1000),
    'incrementAsync Saga must call delay(1000)'
  )

  assert.deepEqual(
    gen.next().value,
    put({type: 'INCREMENT'}),
    'incrementAsync Saga must dispatch an INCREMENT action'
  )

  assert.deepEqual(
    gen.next(),
    { done: true, value: undefined },
    'incrementAsync Saga must be done'
  )

  assert.end()
});
```

`put` 과 `call` 이 순수 객체를 반환하기 때문에, 테스트 코드에서 같은 함수들을 재사용할수 있게 되었고, `incrementAsync` 의 로직을 테스트 하기 위해 단순히 제너레이터를 반복하고 값에 대해 `deepEqual` 테스트를 할수 있게 되었습니다.

위의 테스트를 진행하기 위한 코드입니다:

```sh
$ npm test
```

이 테스트는 콘솔에 결과를 보고해야 합니다.

> 이 글은 [공식문서 의 Beginner tutorial](https://redux-saga.js.org/) 을 한국어로 번역한 글입니다.
>
> 전체 문서는 [한국어 번역 문서](https://mskims.github.io/redux-saga-in-korean/) 를 참조해주세요.
