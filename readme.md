# urequire-rc-rxjs5-custom-build

## Build custom editions of [*RxJS 5*](https://github.com/ReactiveX/rxjs), with this [uRequire](http://urequire.org) ResourceConverter.

## Intro 

Build your *own custom build of `RxJS 5`*, with a custom `Observable` with added (patched) operators on streams (eg `map`, `filter` etc), along with static methods attached to Observable (like `Observable.fromEvent`) as you would expect, and other general features picking :-) 

Use the specially build `rxjs5-custom-build.js` file as a module for your optimized RxJS 5 app builds, or release it as a separate npm module to be reused. 

## Why
 
The RxJS library is a hefty one, as it takes ~800K of code for the whole library.

There is no custom build at the moment, so here it is. Note how easy such a tool can be build using uRequire & ResourceConverters (check `source/code/urequire-rc-rxjs5-custom-build.js`).  

## How it works

In http://reactivex.io/rxjs/manual/installation.html#es6-via-npm it mentions  

    _To import only what you need by patching (this is useful for size-sensitive bundling):_    
        
        ```    
            import {Observable} from 'rxjs/Observable';
            import 'rxjs/add/operator/map';
                 
            Observable.of(1,2,3).map(x => x + '!!!'); // etc 
        ```

This isn't so great but things get worse if you want to use a static method of `Observable` like `fromEvent`. You first have to      
`import { fromEvent } from 'rxjs/observable/fromEvent';` and then you need to either `Observable.fromEvent = fromEvent;` or you need to do a `fromEvent(el, 'click')` which is unnatural compared to the normal usage (i.e `import Rx from 'rxjs'` and then `Rx.Observable.fromEvent(el, 'click')`, which is how your app's source code is probably written as.     

uRequire ResourceConverter for RxJS 5 builds your custom RxJS 5, aiming to behave exactly like the RxJS full build (but only with your selections). 


# How to use

You declare the options: 

 * `addOperators`: which operators you want to be added (patched) to instances (eg `['map', 'filter',..]`).  
    
 * `staticImports`: which static methods you want to import and attach to Observable (eg `['fromEvent', ...]`).

in the `urequire` config , eg : 

``` 
  urequire: 
     ...
     path: 'src'
     dstPath: 'build'
     resources: [
       [ 'rxjs5-custom-build', {  // the options Object
            addOperators: [ 'map', 'filter' ]
            staticImports: [ 'fromEvent' ]
          }
       ]
     ]
 ...
```     

Then, in your `src/MyAppFile.js` you can use you custom module simply like `import Rx from './rxjs5-custom-build';`, or simply make it your `package.json`'s main and thus create you own custom distribution of RxJS 5. 

The generated file is always named `rxjs5-custom-build.js`, so *you need to have* a file `src/rxjs5-custom-build.js` (at the root of `src` or what ever the `path` is) that is empty or with some comments - its contents don't matter. When you build, the `build/rxjs5-custom-build.js` (or wherever `dstPath` is in you project) will have the auto generated custom RxJS build code (in ES6 format only for now).

The generated file by default is in ES6, but you can easily convert to ES5 using `urequire-rc-babeljs` after the generation, for example: 
 
```
    resources: [
    
        [ 'rxjs5-custom-build', {
            addOperators: [ 'map', 'filter' ]
            staticImports: [ 'fromEvent' ]
          }
        ],
        
        [ 'babeljs', {
           plugins: ['add-module-exports'],
           presets: ['es2015'] 
          }
        ]
    ]
``` 

# License

The MIT License

Copyright (c) 2014-2016 Angelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
