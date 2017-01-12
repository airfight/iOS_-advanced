//
//  DrawingView.m
//  高效绘图
//
//  Created by ZGY on 2017/1/11.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/11  16:29
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "DrawingView.h"

@interface DrawingView()

@property (nonatomic,strong) UIBezierPath *path;

@end

@implementation DrawingView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.path = [[UIBezierPath alloc] init];
#if 0   //此方法每次都绘制导致FPS降低
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
        
        self.path.lineWidth = 5;
#endif
        CAShapeLayer *shapLayer = (CAShapeLayer *)self.layer;
        shapLayer.strokeColor = [UIColor redColor].CGColor;
        shapLayer.fillColor = [UIColor clearColor].CGColor;
        shapLayer.lineJoin = kCALineJoinRound;
        shapLayer.lineCap = kCALineCapRound;
        shapLayer.lineWidth = 5;
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.path = [[UIBezierPath alloc] init];
#if 0
    self.path.lineJoinStyle = kCGLineJoinRound;
    self.path.lineCapStyle = kCGLineCapRound;
    
    self.path.lineWidth = 5;
#endif
    CAShapeLayer *shapLayer = (CAShapeLayer *)self.layer;
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.lineJoin = kCALineJoinRound;
    shapLayer.lineCap = kCALineCapRound;
    shapLayer.lineWidth = 5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path moveToPoint:point];
    
#if 0
    //重绘
    [self setNeedsDisplay];
#endif
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:point];
    
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}


- (void)drawRect:(CGRect)rect
{
#if 0
    //
    [[UIColor clearColor] setFill];
    [[UIColor redColor]  setStroke];
    [self.path stroke];
#endif
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
