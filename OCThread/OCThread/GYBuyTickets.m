//
//  GYBuyTickets.m
//  OCThread
//
//  Created by ZGY on 2017/12/26.
//Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/12/26  下午2:02
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "GYBuyTickets.h"
#define TotalTickets 150
@interface GYBuyTickets()

@property  int surplsTickets;
@property  int saletickets;
@property (nonatomic,strong) NSThread *SH_Buy;
@property (nonatomic,strong) NSThread *HN_Buy;

@property (nonatomic,strong) NSCondition *condition;

@end

@implementation GYBuyTickets

- (instancetype)init {
    
    if (self = [super init]) {
        self.surplsTickets = TotalTickets;
        self.SH_Buy = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.SH_Buy setName:@"SH_Buy"];
        self.HN_Buy = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.HN_Buy setName:@"HN_Buy"];
        self.condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)sale {
    
    while (true) {
        
//        @synchronized(self){
        [self.condition lock];
            if (self.surplsTickets > 0) {
                [NSThread sleepForTimeInterval:0.5];
                self.surplsTickets--;
                self.saletickets = TotalTickets - self.surplsTickets;
                NSLog(@"%@：当前余票:%d,售出:%d",[NSThread currentThread].name,self.surplsTickets,self.saletickets);
                
            }
//        }
        [self.condition unlock];        
        
    }
    
}

- (void)start{
    [self.SH_Buy start];
    [self.HN_Buy start];
    
}

@end
