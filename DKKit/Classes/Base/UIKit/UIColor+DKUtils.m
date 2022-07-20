//
//  UIColor+DKUtils.m
//  DKKit
//
//  Created by admin on 2022/7/19.
//

#import "UIColor+DKUtils.h"
#import "NSString+DKUtils.h"

@implementation UIColor (DKUtils)

static inline CGFloat dkColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length)
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)dk_colorWithHex:(UInt32)hex
{
    return [UIColor dk_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)dk_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)dk_colorWithHexString:(NSString *)hexString
{
    NSString *colorString = [[hexString dk_stringByTrim] uppercaseString];
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    } else if ([colorString hasPrefix:@"0X"]) {
        colorString = [colorString substringFromIndex:2];
    }
    
    CGFloat alpha, red, blue, green;
    
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = dkColorComponentFrom(colorString, 0, 1);
            green = dkColorComponentFrom(colorString, 1, 1);
            blue  = dkColorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = dkColorComponentFrom(colorString, 0, 1);
            red   = dkColorComponentFrom(colorString, 1, 1);
            green = dkColorComponentFrom(colorString, 2, 1);
            blue  = dkColorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = dkColorComponentFrom(colorString, 0, 2);
            green = dkColorComponentFrom(colorString, 2, 2);
            blue  = dkColorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = dkColorComponentFrom(colorString, 0, 2);
            red   = dkColorComponentFrom(colorString, 2, 2);
            green = dkColorComponentFrom(colorString, 4, 2);
            blue  = dkColorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)dk_randomColor
{
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
