//
//  GCDCanceller.m
//  NDanale
//
//  Created by Tristan on 2017/4/18.
//  Copyright © 2017年 Danale. All rights reserved.
//

#import "GCDCanceller.h"

@implementation GCDCanceller

+ (void)gcdLater:(NSTimeInterval)time block:(gcdBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

+ (GCDTask)gcdDelay:(NSTimeInterval)time task:(gcdBlock)block {
    __block dispatch_block_t closure = block;
    __block GCDTask result;
    GCDTask delayedClosure = ^(BOOL cancel){
        if (closure) {
            if (!cancel) {
                dispatch_async(dispatch_get_main_queue(), closure);
            }
        }
        closure = nil;
        result = nil;
    };
    result = delayedClosure;
    [self gcdLater:time block:^{
        if (result)
            result(NO);
    }];
    
    return result;
}

+ (void)gcdCancel:(GCDTask)task {
    task(YES);
}

@end
