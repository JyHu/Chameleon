# EasyTheme


## 简介

[之前写的一些相关的内容](http://www.auu.space/2017/02/14/iOS-APP%E6%8D%A2%E8%82%A4%E5%8A%9F%E8%83%BD%E7%9A%84%E5%AE%9E%E7%8E%B0/)，现在是把里面的一些实现和使用方式给做了一些修改，不过中心思想还是一样的，那就是给每一个皮肤属性设置对应的标志。

## 使用

`pod 'EasyTheme', '~> 0.2.0'`

对于皮肤的`json`文件的管理提供两种方式，一种是直接把所有的信息丢给`APPAppearanceManager`，一种是自己新建一个管理类，实现`APPAppearanceDelegate`代理。

### 如何自己新建一个皮肤属性的设置

比如`UILabel`的`textColor`属性。
新建一个`category`，然后添加一个属性`UIColor *app_textColor`，然后添加实现:

```
// 缓存的属性的方法
- (void)setApp_textColor:(UIColor *)app_textColor {
    APPColorParamAssert(app_textColor)
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}
```

外部在使用的时候，可以直接这样：

```
UILabel *label = [[UILabel alloc] init];
label.app_textColor = [[UIColor blackColor] appearanceIdentifier:@"color.title"];
```

这样直接切换皮肤的时候就可以了。

## 如何新建一个自定义的属性

皮肤属性的设置，其实是缓存了设置这些属性的方法，比如对`CALayer`的属性做设置，定义了一个如下这样的方法，那么久能跟上面的设置一样来设置这个属性了。

```
- (void)setupLayerBorderColor:(UIColor *)color {
    if (color) {
        self.borderColor = color.CGColor;
    }
}
```

### 如何处理多属性的皮肤样式

可以看`Demo`里的`HMSegmentedControl+AUUHelper.h`文件。

### 如果和拦截一个属性的设置

在做属性缓存的时候，有这样一个方法`cacheThemeParams:forSelector:manualInvokeSelector:`，最后一个参数即是丢给外部处理的方法，当你设置了这个参数以后，里面就会在遇到当前设置对应的`identifier`的时候，把内容丢出来，自己处理。

### 如何下载网络图片

内部默认的是使用`SDWebImage`去下载，外部可以通过实现`webImageWithURLString:downloadCompletion:`协议方法也可以做到。

## 皮肤的数据的格式

### 颜色

所有的颜色都在`colors`字典下，每个颜色属性的值可以是直接是一个16进制的颜色值，也可以是一个字典类型的对象，可用于后续更多属性的设置。

### 图片

所有的图片都在`images`字典下，图片属性的设置方式可以有多种：

1. 一个图片的名字，使用`name`字段，这样会在本地用`imageNamed`去读取，适合小图片和已经放在项目里的图片；
2. 一个图片的名字，使用`file`字段，这样会在本地用`imageWithContentsOfFile`去读取，适合大图片和打包好的`bundle`资源文件；
3. 一个16进制颜色值，使用`color`字段，这样会直接通过代码生成一个纯色图片；
4. 一个图片地址，使用`path`字段，这样通过`SDWebImage`下载，或者直接调用外部的下载方法。

### 自定义的属性

所有的自定义属性都在`appearance`字典下，用于设置复杂的属性，或者自定义的一些属性。

### 下面是一个例子

```
{
    "colors": {
        "color" : "c6ddfa",
        "color.background" : "c6ddfa",
        "color.text.subtitle" : {
            "hex" : "c6ddfa"
        }
    },
    "images": {
        "image": {
            "name": "3.jpg"
        },
        "image.background.navbar" : {
            "color": "c6ddfa"
        },
        "image.refresh.arrow" : {
            "color": "f17775",
        },
        "image.head.head1": {
            "name": "1.jpeg"
        },
        "image.head.head2": {
            "name": "2.jpeg"
        },
        "image.head.head3": {
            "path" : "http://www.qqjia.com/z/09/tu10292_19.jpg"
        }
    },
    "appearance" : {
        "appearance.segment" : {
            "background" : "c6ddfa",
            "titlecolor" : "4a4a4a",
            "indicatorColor" : "4a4a4a",
            "selectedTitleColor" : "f17775",
            "bottomBorder" : "4a4a4a"
        }
    }
}

```

## Latest Update

`2018-03-25`
