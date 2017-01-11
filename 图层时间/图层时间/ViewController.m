//
//  ViewController.m
//  图层时间
//
//  Created by zhuguangyang on 2017/1/10.
//  Copyright © 2017年 GYJade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) CALayer *colorLayer;

@property (nonatomic,strong) UIView *layerView;


@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

#if 1
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
//    self.Subview.backgroundColor = [UIColor redColor];
    [self.view addSubview:_layerView];
    
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
//    [self.layerView.layer addSublayer:self.colorLayer];
#endif
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CGPoint controlPoint1, controlPoint2;
    
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    CAShapeLayer *shaplarer = [CAShapeLayer layer];
    shaplarer.strokeColor = [UIColor redColor].CGColor;
    shaplarer.fillColor = [UIColor clearColor].CGColor;
    shaplarer.lineWidth = 4.0f;
    shaplarer.path = path.CGPath;
    [self.layerView.layer addSublayer:shaplarer];
    
    self.layerView.layer.geometryFlipped = YES;
    
    [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    
    
//    self.colorLayer = [CALayer layer];
//    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
//    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
//    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:self.colorLayer];
}


float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
    //configure the transaction
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    //set the position
//    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
//    //commit transaction
//    [CATransaction commit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
