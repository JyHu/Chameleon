
皮肤属性是一个json文件来管理，里面包含着各个小组件的属性设置信息。

## 使用

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
