//
//  NSString+Regex.h
//  HFKitDemo
//
//  Created by helfy on 16/6/29.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

//用户名 6到20个字符
+(NSString *)hf_UserNameRegex;
//密码 6到20个字符
+(NSString *)hf_PassWordRegex;
//邮箱地址
+(NSString *)hf_EmailRegex;
//电话号码 1开头的11位数字
+(NSString *)hf_PhoneNumberRegex;
//车牌号
+(NSString *)hf_CarNoRegex;
//身份证
+(NSString *)hf_IdentityCardPredicate;
@end
