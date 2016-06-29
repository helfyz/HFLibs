//
//  NSString+Regex.m
//  HFKitDemo
//
//  Created by helfy on 16/6/29.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString(Regex)

+(NSString *)userNameRegex
{
    return @"^[A-Za-z0-9]{6,20}+$";
}
+(NSString *)passWordRegex
{
    return @"^[a-zA-Z0-9]{6,20}+$";
}
+(NSString *)emailRegex
{
    return  @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
}

+(NSString *)phoneNumberRegex
{
    return  @"^1\\d{10}";
}

+(NSString *)carNoRegex
{
    return  @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
}


+(NSString *)identityCardPredicate
{
    return @"^(\\d{14}|\\d{17})(\\d|[xX])$";
}
@end
