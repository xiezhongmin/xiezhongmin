//
//  UIColor+DKUtils.h
//  DKKit
//
//  Created by admin on 2022/7/19.
//

#import <UIKit/UIKit.h>

@interface UIColor (DKUtils)

/**
 * Example: 0x66ccff
 */
+ (UIColor *)dk_colorWithHex:(uint32_t)hex;

+ (UIColor *)dk_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

/**
 * @discussion:
    Valid format: #RGB #ARGB #RRGGBB #AARRGGBB 0xRGB ...
 *  Example: @"0xF0F", @"66ccff", @"#66CCFF88"
 */
+ (UIColor *)dk_colorWithHexString:(NSString *)hexString;

+ (UIColor *)dk_randomColor;

@end

