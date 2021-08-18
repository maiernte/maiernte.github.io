---
title: JavaScript & Typescript技术摘要
date: 2019-09-14 09:32:15
urlname: javascript-typescript-skills
toc: true
tags: [Hexo]
categories: [IT, Code]
notshow: false
---

Javasript 和 Typescript 的重要技巧。

<!--more-->


### 零散知识点

- 列举 [Enum](https://www.typescriptlang.org/docs/handbook/enums.html) 

### Promise

##### 输出链条

文档 [Promises chaning](https://javascript.info/promise-chaining) 

:pencil2: 可以在 `then` 函数里面跑出 结果 `或者` 第二个 `Promise` 

##### 等待多个 Promise

```javascript
let p1 = promise1
let p2 = promise2
const promises = Promise.all([p1, p2])
return promises
```

### 声明以及定义扩展

在 `*.d.ts` 文件中声明类型 

```javascript
declare type Book = {
	title: string,
	comment?: string
}
```

 对 JavaScript 的原型进行扩展， 在一个 TS 文件进行定义和实现

```typescript
// ...path/common.ts
export {} // this will make it module
declare global {
  interface String {
    IsNullOrEmpty():boolean;
    Latex(color?:string):string;
  }
}

String.prototype.IsNullOrEmpty = function(){
    return this == undefined || this == null || this == ""
}
```

在需要的地方引用

```typescript
import '..path/common';

let str = ""
const is_it_empty = str.IsNullOrEmpty()
```



### 读取文本

###### Html5 标准按钮

```html
<div type='file' (change)='LoadLocalFile($event)'></div>
```

Javascript 读取文本内容并转为数据库 (*使用 sql.js*)

```javascript
LoadLocalFile(file) {
    const fileurl: File = file.target.files[0];
    const reader = new FileReader();
    reader.onload = () => {
      console.log('read file:', reader.result);
      const buffer = reader.result;
      const Uints = new Uint8Array(buffer as ArrayBuffer);
      const db = new SQL.Database(Uints);
      const nodes = db.exec('SELECT * From node');
      console.log(nodes);
    };

    reader.readAsArrayBuffer(fileurl);
  }
```

###### 使用nix-file-helpers 插件

[文档地址](https://www.npmjs.com/package/ngx-file-helpers)

[演示地址](https://www.npmjs.com/package/ngx-file-helpers)

Html

```html
<ion-button   ngxFilePicker #filePicker="ngxFilePicker" 
    [readMode]="readMode"
    (readStart)="onReadStart($event)" 
    (filePick)="onFilePicked($event)"
    (readEnd)="onReadEnd($event)">导入案例</ion-button>
```

代码,读取文件

```javascript
onFilePicked(file: ReadFile) {
    const Uints = new Uint8Array(file.content as ArrayBuffer);
    const db = new SQL.Database(Uints);
    const nodes = db.exec('SELECT * From node');
    console.log(nodes);
  }
```





### 测试

###### 引用第三方js文件

在 **angular.json** 文件的 `test-->scripts` 中添加需要引用的文件。