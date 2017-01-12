//
//  GYDrawingView.m
//  高效绘图
//
//  Created by ZGY on 2017/1/11.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/11  16:51
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "GYDrawingView.h"

#define BRUSH_SIZE 32

@interface GYDrawingView()

@property (nonatomic,strong) NSMutableArray *storkes;

@end

@implementation GYDrawingView


- (instancetype)init
{
    if (self = [super init]) {
        self.storkes = [NSMutableArray array];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.storkes = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //收集手势位置
    [self addBrushStrokeAtPoint:point];
    
    
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{
    [self.storkes addObject:[NSValue valueWithCGPoint:point]];
    
#if 0
    [self setNeedsDisplay];
#endif
    
    //传入绘制的位置、防止重复绘制
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
    
}

- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect
{
    
    for (NSValue *value in self.storkes) {
        CGPoint point = [value CGPointValue];
        
//        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE / 2, point.y - BRUSH_SIZE/2 ,BRUSH_SIZE , BRUSH_SIZE);
        
        CGRect brushRect = [self brushRectForPoint:point];
        
        if (CGRectIntersectsRect(rect, brushRect)) {
        
            [[UIImage imageNamed:@"backBg"] drawInRect:brushRect];
        }
        
        
//        [[UIImage imageNamed:@"backBg"] drawInRect:brushRect];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
