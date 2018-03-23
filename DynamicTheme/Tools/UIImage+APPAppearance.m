//
//  UIImage+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIImage+APPAppearance.h"
#import "NSString+APPAppearance.h"
#import "APPAppearanceManager.h"
#import "UIColor+AUUAppearance.h"
#import <objc/runtime.h>

@implementation UIImage (APPAppearance)

- (UIImage *)correctImageWithURLString:(NSString *__autoreleasing *)urlString {
    
    if (self.appearanceIdentifier) {
        return [self imageWithIdentifier:self.appearanceIdentifier imageURLPath:urlString];
    }
    
    return self;
}

- (UIImage *)imageWithIdentifier:(NSString *)identifier imageURLPath:(NSString * __autoreleasing *)urlPath {
    if (!identifier) {
        return self;
    }
    
    NSDictionary *imageInfo = [APPAppearanceManager sharedManager].imagesInfo[identifier];
    
    if (!imageInfo) {
        return [self imageWithIdentifier:[identifier superIdentifier] imageURLPath:urlPath];
    }
    
    NSInteger type = [imageInfo[@"type"] integerValue];
    
    switch (type) {
            
        case 0: {
            NSString *imgName = imageInfo[@"name"];
            if (imgName) {
                return [UIImage imageNamed:imgName];
            }
        }
            break;
            
        case 1: {
            NSString *imgName = imageInfo[@"name"];
            if (imgName) {
                NSString *imgPath =[[APPAppearanceManager sharedManager].currentThemePath stringByAppendingPathComponent:imgName];
                if ([[NSFileManager defaultManager] fileExistsAtPath:imgPath]) {
                    return [UIImage imageWithContentsOfFile:imgPath];
                }
            }
        }
            break;
            
        case 2: {
            NSString *hexColorString = imageInfo[@"color"];
            if (hexColorString) {
                UIColor *color = [UIColor app_colorWithHexString:hexColorString];
                if (color) {
                    return [UIImage app_imageWithColor:color];
                }
            }
        }
            break;
            
        case 3: {
            *urlPath = imageInfo[@"path"];
            return nil;
        }
            
        default:
            break;
    }
    
    return self;
}

+ (UIImage *)app_imageWithColor:(UIColor *)color {
    return [self app_imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)app_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - APPAppearanceParamProtocol

- (instancetype)appearanceIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(appearanceIdentifier:),
                             identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return self;
}
- (NSString *)appearanceIdentifier {
    return objc_getAssociatedObject(self, @selector(appearanceIdentifier:));
}

@end
