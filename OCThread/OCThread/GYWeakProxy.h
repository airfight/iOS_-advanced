//
//  GYWeakProxy.h
//  OCThread
//
//  Created by ZGY on 2018/1/4.
//Copyright © 2018年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2018/1/4  下午1:24
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import <Foundation/Foundation.h>

@interface GYWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;


@end
