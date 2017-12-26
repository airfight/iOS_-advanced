//
//  GYOperation.m
//  OCThread
//
//  Created by ZGY on 2017/12/8.
//Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/12/8  上午11:18
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "GYOperation.h"

@interface GYOperation()

@property (nonatomic,copy) NSString* name;
@property BOOL over;
@end

@implementation GYOperation

- (instancetype)initWithName:(NSString *)name {
    
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

- (void)main {
 
//    for (int i = 0; i < 3; i++) {
//        NSLog(@"%d--%@",i,self.name);
//    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:1];
        if (self.isCancelled) {
            return ;
        }
        
        NSLog(@"----%@",self.name);
        self.over = YES;
    });
    
    //标志当前任务结束 结束当前线程 
    while (!self.over && !self.isCancelled) {
        [[NSRunLoop currentRunLoop ] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

@end
