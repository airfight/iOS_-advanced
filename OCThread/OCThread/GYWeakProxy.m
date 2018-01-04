//
//  GYWeakProxy.m
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

#import "GYWeakProxy.h"

@interface GYWeakProxy()

@property (nonatomic, weak, readonly) id target;

@end

@implementation GYWeakProxy

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
    
}
+ (instancetype)proxyWithTarget:(id)target
{
    return [[self alloc] initWithTarget:target];
    
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
    
}
- (void)forwardInvocation:(NSInvocation *)invocation
{   if ([_target respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:_target];
        
    }
    
}
- (NSUInteger)hash
{
    return [_target hash];
    
}
- (Class)superclass
{
    return [_target superclass];
    
}
- (Class)class
{
    return [_target class];
    
}
- (BOOL)isKindOfClass:(Class)aClass
{
    return [_target isKindOfClass:aClass];
    
}
- (BOOL)isMemberOfClass:(Class)aClass
{
    return [_target isMemberOfClass:aClass];
    
}
- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [_target conformsToProtocol:aProtocol];
    
}
- (BOOL)isProxy
{ return YES; }
- (NSString *)description
{ return [_target description]; }
- (NSString *)debugDescription
{ return [_target debugDescription]; }

@end
