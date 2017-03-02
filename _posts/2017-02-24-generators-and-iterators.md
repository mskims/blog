---
layout: post
title: "파이썬의 이터레이터와 제너레이터"
tags: [python]
---

# 참고한 문서
* [http://stackoverflow.com/questions/2776829/difference-between-pythons-generators-and-iterators](http://stackoverflow.com/questions/2776829/difference-between-pythons-generators-and-iterators)
* [https://wiki.python.org/moin/Generators](https://wiki.python.org/moin/Generators)
* [https://wiki.python.org/moin/Iterator](https://wiki.python.org/moin/Iterator)

# Wiki says
> Generators functions allow you to declare a function that behaves like an iterator, i.e. it can be used in a for loop.

> An iterator is an object that implements next. next is expected to return the next element of the iterable object that returned it, and raise a StopIteration exception when no more elements are available.

```python
def some(x):
  return x+1

print(some(1))
```
