---
layout: post
title: "ES6 destructuring assignment"
tags: [javascript, es6]
---
{% highlight js %}
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
{% endhighlight %}
