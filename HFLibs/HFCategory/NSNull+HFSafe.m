//
//  NSNull+HFSafe.m
//  HFKitDemo
//
//  Created by helfy on 16/8/2.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "NSNull+HFSafe.h"

@implementation NSNull (HFSafe)


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    invocation.target = nil;
    [invocation invoke];
}

@end
