//
//  ViewController.m
//  显示动画
//
//  Created by zhuguangyang on 16/9/27.
//  Copyright © 2016年 Giant. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIApplicationDelegate>

@property (nonatomic,strong) CALayer *colorLayer;

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,copy) NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 属性动画
     #if 0
     
     //create sublayer
     self.colorLayer = [CALayer layer];
     self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
     self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
     //add it to our view
     [self.layerView.layer addSublayer:self.colorLayer];
     #endif
     #if 0
     UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
     [bezierPath moveToPoint:CGPointMake(0, 150)];
     
     [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
     
     
     CAShapeLayer *pathLayer = [CAShapeLayer layer];
     pathLayer.path = bezierPath.CGPath;
     pathLayer.fillColor = [UIColor clearColor].CGColor;
     pathLayer.strokeColor = [UIColor redColor].CGColor;
     pathLayer.lineWidth = 3.0f;
     
     [self.view.layer addSublayer:pathLayer];
     
     //
     CALayer *shipLayer = [CALayer layer];
     shipLayer.frame = CGRectMake(0, 0, 64, 64);
     shipLayer.position = CGPointMake(0, 150);
     shipLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"v.jpg"].CGImage);
     [self.view.layer addSublayer:shipLayer];
     
     CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
     animation.keyPath = @"position";
     animation.duration = 4.0;
     animation.repeatCount = 0;
     animation.path = bezierPath.CGPath;
     //修改图片头的方向随着曲线方向改变
     animation.rotationMode = kCAAnimationRotateAuto;
     
     [shipLayer addAnimation:animation forKey:nil];
     #endif
     #if 0
     
     CALayer *shipLayer = [CALayer layer];
     shipLayer.frame = CGRectMake(0, 0, 128, 128);
     shipLayer.position = CGPointMake(150, 150);
     shipLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"v.jpg"].CGImage);
     
     [self.view.layer addSublayer:shipLayer];
     
     CABasicAnimation *animation = [CABasicAnimation animation];
     animation.keyPath = @"transform";
     animation.duration = 2.0;
     animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
     
     [shipLayer addAnimation:animation forKey:nil];
     
     #endif
     
     #if 1
     
     //add the ship
     CALayer *shipLayer = [CALayer layer];
     shipLayer.frame = CGRectMake(0, 0, 128, 128);
     shipLayer.position = CGPointMake(150, 150);
     shipLayer.contents = (__bridge id)[UIImage imageNamed: @"v.jpg"].CGImage;
     [self.view.layer addSublayer:shipLayer];
     //animate the ship rotation
     CABasicAnimation *animation = [CABasicAnimation animation];
     animation.keyPath = @"transform.rotation";
     animation.duration = 2.0;
     animation.repeatCount = 0;
     animation.byValue = @(M_PI * 2);
     [shipLayer addAnimation:animation forKey:nil];
     
     
     #endif
     */
    //动画组
#if 0
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
#endif
#if 1
    
    //    self.images = @[[UIImage imageNamed:@"v.jpg"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"v.jpg"],[UIImage imageNamed:@"1"]];
    
    
#endif
    
}
- (IBAction)changeColor:(id)sender {
    //create a new random color
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //    
    //    CABasicAnimation *animation = [CABasicAnimation animation];
    //    animation.keyPath = @"backgroundColor";
    //    animation.toValue = (__bridge id _Nullable)(color.CGColor);
    //    animation.delegate = self;
    //    
    //    [self.colorLayer addAnimation:animation forKey:nil];
    
#if 0
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor whiteColor].CGColor ];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
#endif
#if 1
    CATransition *transition = [CATransition animation];
    //type
    //kCATransitionFade
    //kCATransitionMoveIn
    //kCATransitionPush
    //kCATransitionReveal
    transition.type = kCATransitionFade;
    //型都有一个默认的动画方向，它们都从左侧滑入，但是你可以通过subtype来控制它们的方向，提供了如下四种类型：
    //    kCATransitionFromRight
    //    kCATransitionFromLeft
    //    kCATransitionFromTop
    //    kCATransitionFromBottom
    transition.subtype = kCATransitionFromBottom;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
    //    _imageView.contentMode = UIViewContentModeScaleAspectFit;
#endif
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.colorLayer.backgroundColor = (__bridge CGColorRef _Nullable)(anim.toValue);
    [CATransaction commit];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
