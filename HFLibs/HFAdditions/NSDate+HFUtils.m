//
//  NSDate+HFUtils.m
//  HFUtilsDemo
//
//  Created by helfy on 15/9/8.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "NSDate+HFUtils.h"

@implementation NSDate (HFUtils)

- (NSString *)stringWithDateFormatString:(NSString *)formateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:locale];
    [formatter setDateFormat:formateString];
    return [formatter stringFromDate:self];
}
@end
