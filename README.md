# MyComponents

[![CI Status](http://img.shields.io/travis/CharlsPrince/MyComponents.svg?style=flat)](https://travis-ci.org/CharlsPrince/MyComponents)
[![Version](https://img.shields.io/cocoapods/v/MyComponents.svg?style=flat)](http://cocoapods.org/pods/MyComponents)
[![License](https://img.shields.io/cocoapods/l/MyComponents.svg?style=flat)](http://cocoapods.org/pods/MyComponents)
[![Platform](https://img.shields.io/cocoapods/p/MyComponents.svg?style=flat)](http://cocoapods.org/pods/MyComponents)

## Example

要运行示例项目，请将仓库clone到本地，cd到仓库根目录，执行`pod install`即可。

## 简介
------
**MyComponents** (OC版本) 是一个组件集，将开发中常用的组件集合起来，提供快捷操作方法，尽量避免一个项目引入多个库。

## 安装
------

**MyComponents** 可以通过 **Cocoapods** 进行安装，可以复制下面的文字到 Podfile 中：

如果想要使用组件库中所有的组件时，可以:
```ruby
target '项目名称' do
	pod "MyComponents", '~> [版本号]'
end
```

如果想要使用组件库中某个组件时，可以:
```ruby
target '项目名称' do
	pod "MyComponents/**", '~> [版本号]'
end

按需加载 EasyKVO 组件
target '项目名称' do
	pod "MyComponents/EasyKVO", '~> 0.1.1'
end

```

## 组件结构
> * EasyKVO: 便捷的KVO监听方式


## 使用方法
### EasyKVO
便捷的KVO监听方式，在需要使用的位置导入头文件:  

```ruby
Cocoapods导入方式
#import <MyComponents/NSObject+EasyKVO.h> 
拖拽文件导入方式
#import "MyComponents/NSObject+EasyKVO.h"
```
接口说明:
```ruby
// 添加KVO监听
- (void)easy_addObserver:(NSObject * _Nonnull)object forKeyPath:(NSString * _Nonnull)keyPath easyBlock:(nullable EasyBlock)block;

// 移除所有的监听者
- (void)easy_removeAllObservers;
 
// 移除 keyPath 对应的所有监听者
- (void)easy_removeObserverForKeyPath:(nullable NSString *)keyPath;

```


## 作者

CharlsPrince, 961629701@qq.com



## License

MyComponents is available under the MIT license. See the LICENSE file for more info.


