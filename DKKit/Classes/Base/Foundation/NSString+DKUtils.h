//
//  NSString+DKUtils.h
//  DKKit
//
//  Created by admin on 2022/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DKUtils)

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)dk_stringByTrim;

/**
 Returns YES if the target string is contained within the receiver.
 @param string A string to test the the receiver.
 
 @discussion Apple has implemented this method in iOS8.
 */
- (BOOL)dk_containsString:(NSString *)string;

/**
 Returns an NSData using UTF-8 encoding.
 */
- (nullable NSData *)dk_dataValue;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)dk_isNotBlank;

@end

NS_ASSUME_NONNULL_END
