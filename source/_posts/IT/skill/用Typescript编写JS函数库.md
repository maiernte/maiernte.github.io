---
title: 用TypeScript编写JS函数库
date: 2019-08-16 22:15:28
urlname: TypeScript-build-JS-Package
toc: true
tags: [工具]
categories: [IT, skill]
---

本文具体介绍如何用TypeScript编写JavaScript库文件，以及制作npm工具包。主要参考下面两篇文章。我也省却一步步解释，只罗列相关的代码和我遇到的坑。想知道代码含义的请参阅原帖

- [TypeScript第一步](http://imzc.me/dev/2016/11/22/getting-start-with-typescript/)
- [如何使用Gulp构建TypeScript](https://www.gowhich.com/blog/869)
- [从Javascript迁移到Typescript](https://zhongsp.gitbooks.io/typescript-handbook/doc/handbook/tutorials/Migrating%20from%20JavaScript.html) *只看相关的那一章就可以*


<!-- more -->

# 安装 TypeScript

终端执行 `npm install typescript -g` 

```sh
$ tsc --version
Version 3.5.3
```

# 创建工程

1. 初始化项目

```sh
mkdir typescript_demo && cd typescript_demo
npm init -y # 初始化项目，会生成 package.json 文件
```

2. 安装Gulp， 并在项目根目录下新建 `gulpfile.js` 文件

```sh
npm install gulp-cli gulp typescript gulp-typescript --save-dev
```

3. 在命令行中执行 `tsc --init` 可以在当前目录中快速创建一个 tsconfig.json 文件。

4. 安装 Browserify ：目的是把所有**ts**文件打包成一个单一的**js**文件。

```sh
npm install browserify tsify vinyl-source-stream --save-dev
```

5. Watchify、Babel和Uglify ：目的是让编译器保持运行，无需每次修改手动编译。

npm install watchify gulp-util --save-dev

```sh
npm install watchify gulp-util --save-dev
```

6. 安装 Uglify ： 将输出文件 bundle.js 压缩

```sh
npm install gulp-uglify vinyl-buffer gulp-sourcemaps --save-dev
```

7. Babel ：允许按新标准**ES6**编写代码，而最终会编译**es05**标准，兼容低版本浏览器。

```sh
npm install babelify babel-core babel-preset-env vinyl-buffer gulp-sourcemaps --save-dev
```

:bangbang: 安装中出现了错误, 显示babelify 版本太低. 将命令改为 `npm install babelify@8` 就能顺利进行下去了.




8. 编写主文件 `src/main.ts` (*名字随便起*)，在 `package.json` 中改为 $ "main": "./dist/main.js", $。创建两文件夹 `src` 和 `dist`，分别放置原文件和编译后的文件。为演示调用，再新建一个 `src/greet.ts` 文件

   ```typescript
   # src/greet.ts
   declare function require(path: string): any;
   
   export function sayHello(name: string) {
       console.log(ln)
       return `Hallo von ${name}`;
   }
   ```

   ```typescript
   # src/main.ts
   import { sayHello } from "./greet";
   
   function showHello(idName: string, name: string) {
       const elt = document.getElementById(idName);
       elt.innerText = sayHello(name);
   }
   
   showHello("greeting", "TypeScript");
   ```

9. 新建 `src/index.html` 

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Hello World!</title>
    </head>
    <body>
        <p id="greeting">Loading ...</p>
        <script src="bundle.js"></script>
    </body>
</html>
```

10. 修改 `gulpfile.js` 

```javascript
const gulp = require("gulp");
const browserify = require("browserify");
const source = require('vinyl-source-stream');
const tsify = require("tsify");
const watchify = require("watchify");
const gutil = require("gulp-util");
const uglify = require('gulp-uglify');
const sourcemaps = require('gulp-sourcemaps');
const buffer = require('vinyl-buffer');
const paths = {
  pages: ['src/*.html']
};

const watchedBrowserify = watchify(browserify({
  basedir: '.',
  debug: true,
  entries: ['src/main.ts'],
  cache: {},
  packageCache: {}
}).plugin(tsify));

gulp.task("copy-html", function () {
  return gulp.src(paths.pages)
    .pipe(gulp.dest("dist"));
})

function browserifyBundle() {
  return watchedBrowserify
    .transform('babelify', {
      presets: ['env'],
      extensions: ['.ts']
    })
    .bundle()
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init({
      loadMaps: true
    }))
    .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest("dist"));
}

gulp.task("browserify", function () {
  return browserifyBundle();
})

gulp.task("default", gulp.series('copy-html', 'browserify'));
watchedBrowserify.on("update", browserifyBundle);
watchedBrowserify.on("log", gutil.log);
```
11. 修改 tsconfig.json

    ```json
    {
        "files": [
            "src/*.ts"
        ],
        "compilerOptions": {
            "noImplicitAny": true,
            "target": "es2015"
        }
    }
    ```

12. 编译并在浏览器打开 `dist/index.html`

```sh
# 通过gulp编译代码
npx gulp
```

> 显示器中会显示 “Hello from TypeScript” 字样。



我们看到 main.ts 调用了 greet.ts 的函数, 并生成一个 bundle.js 文件, 在 index.html 中被加载使用. 



# 调用JavaScript文件

为了使用以前已经存在的JavaScript库文件, 在 src 下新建一个文件夹 libs 用来存放第三方JavaScript. 

> projectRoot
> ├── src/
> │     ├── libs/
> │     │       ├── lunar.js
> │     ├── main.ts
> │     └── greet.ts
> │   
> ├── dist/
> └── tsconfig.json

```javascript
# src/libs/lunar.js

Lunar = {
    Name: "Dick",
    sayHallo:function(){
        return 'i am Lunar';
    }
} 

function Ab () {
    this.a = 1
  }
  
Ab.prototype.seta = function (num) {
    this.a = num
  }
  
Ab.prototype.geta = function (num) {
    return this.a
  }
  
exports.Ab = Ab
exports.Lunar = Lunar;

```

修改 `greet.ts` 文件, 调用 `src/libs/lunar.js` 中的函数和对象

```typescript
declare function require(path: string): any;

var ln = require("./libs/lunar");

export function sayHello(name: string) {
  	ln.Ab = 10
    console.log(ln.Ab)
    return `Hallo von ${name}, ${ln.Lunar.Name}`;
}
```

TypeScript使用`tsconfig.json`文件管理工程配置，例如想包含哪些文件和进行哪些检查。

```json
{
   "compilerOptions": {
     		"noImplicitAny": true,  
        //"outDir": "./dist", //不需要. gulpfile.js 已经处理过了
        "allowJs": true,
        "target": "es2015",
        "esModuleInterop": true /* Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for all imports. Implies 'allowSyntheticDefaultImports'. */
    },
   "files": [
        "src/*.ts"
    ],
    "include": [
        "./src/**/*.js"
    ]
}
```



我们看到网页显示 *Hallo von TypeScript, Dick*,  打开chrome的开发者工具, 看到console 中写出 `10`. 



# Unit-Test

[参考：Unit testing node applications with Typescript -- using nocha and chai](https://journal.artfuldev.com/unit-testing-node-applications-with-typescript-using-mocha-and-chai-384ef05f32b2)

1. 安装测试包文件

```sh
npm install chai mocha ts-node @types/chai @types/mocha --save-dev
```

2. 新建一个test目录专门存放测试文件，并新建一个测试文件 `test/ganzhi.spec.ts`

```typescript
import { expect } from 'chai';
import 'mocha';

describe('干支 function', () => {

    it('should return hello world', () => {
      const result = 'Hello world!';
      expect(result).to.equal('Hello world!');
    });
  
  });
```

3. 在 `package.json` 文件中配置测试参数和路径

```json
{
  "scripts": {
    "test": "mocha -r ts-node/register test/**/*.spec.ts"
  }
}
```

4. 运行测试

> $ npm run test
>
> \> huahets@1.0.0 test /Users/mai/Projects/huahets
>
> \> mocha -r ts-node/register test/**/*.spec.ts
>
>   干支 function
>
> ​    ✓ should return hello world
>
>   1 passing (19ms)



## 错误处理

假设有以下函数调用中`LandMaps.FindCity`会给出一个异常。

```typescript
var result = LandMaps.FindCity("xx省", "xx市");
expect(LandMaps.FindCity.bind(LandMaps, "err", "")).throw("Error Message") # 或者
expect(LandMaps.FindCity.bind(LandMaps, "err", "")).throw(new Error("Error Message"))
```



# 打包

[用 TypeScript 编写函数库](https://www.xuejiayuan.net/blog/27db473912f642d8a5fa0e32af3bb600)

[require.js 官方文档](https://requirejs.org/docs/start.html)

通过上述方式生成的 bundle.js 文件不能被浏览器直接使用。参考上面两个网页提供的方式，可以生成给浏览器用的单一js文件。

1. 新建一个入口文件，将所有接口都连接起来，并统一导出

 ```typescript
   # yixue.ts
   import {TYDate, TYLunar} from "./tylunar";
   import {GanZhi} from "./ganzhi";
   import {ShenSha} from "./shensha";
   import {WuXing, FetchWuXing} from "./wuxing";
   import {Gua} from './gua'
   import {LandMaps} from "./landmaps"
   
   exports.GanZhi = GanZhi
   exports.TYDate = TYDate
   exports.Gua = Gua
 ```
2. 设置`tsconfig.json`让编译后的文件导出到`dist/cmjs`目录

```json
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "dist/cmjs",
    "rootDir": "./src",
    "declaration": true,
    "sourceMap": true,
    "lib": ["dom", "es6"]
  }
}
```

3. 通过命令 tsc 编译

```sh
tsc -P tsconfig.json
```

也可以在 package.json 中设定，然后运行 `npm run build:cmjs` 编译。编译后的 yixue.js 文件就是统一入口。

4. yi xue.js 实际就是个目录，我需要将其打包成一个单一文件。 安装 browserify , 

```sh
browserify dist/cmjs/base/yixue.js --standalone huahejs -o dist/web/yixue.js
```

5. 下载 [require.js](https://requirejs.org/docs/start.html)， 并放到项目目录中。以下方式将 yixue.js 中的 `class GanZhi` 设为当前网页的一个全局函数。其它函数就可以调用。 

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>易学包</title>
        <script type="text/javascript" 
            src="libs/require.js"></script>
    <body >
        <p id="greeting">易学包测试</p>
        <script>
            var newGanZhi

            requirejs(["web/yixue"], function(yixue) {
                console.log(yixue)
                newGanZhi = function(arg){
                    return new yixue.GanZhi(arg)
                } 
  
                init()
            });
              
            function init(){
                console.log("init will be called")
                var ele = document.getElementById("gz1")
                var gz = newGanZhi(1)
                ele.innerText = gz.Name
            }
        </script>

        <div id="gz1"></div>
        <div name="gua">gua</div>
    </body>
</html>
```

6. 在 Node.js 中调用更简单

1. ```javascript
   const {Gua, GanZhi, TYDate} = require("./web/yixue")
   ```








需要更详细代码请下载项目：

[演示项目地址](https://gitee.com/maiernte/typescript-build-js-package)