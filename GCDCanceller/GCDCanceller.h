//
//  GCDCanceller.h
//  NDanale
//
//  Created by Tristan on 2017/4/18.
//  Copyright © 2017年 Danale. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GCDTask)(BOOL cancel);
typedef void(^gcdBlock)();

@interface GCDCanceller : NSObject

+ (GCDTask)gcdDelay:(NSTimeInterval)time task:(gcdBlock)block;
+ (void)gcdCancel:(GCDTask)task;

@end
