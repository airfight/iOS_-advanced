//
//  ViewController.m
//  文件格式
//
//  Created by zhuguangyang on 2017/1/12.
//  Copyright © 2017年 GYJade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(20, 100, 300, 300);
    [self.view addSubview:self.imageView];
    
    UIImage *image = [UIImage imageNamed:@"123.jpg"];
    
    UIImage *mask = [UIImage imageNamed:@"456.png"];
    
    CGColorSpaceRef graySpace = CGColorSpaceCreateDeviceGray();
    CGImageRef maskRef = CGImageCreateCopyWithColorSpace(mask.CGImage, graySpace);
    
    CGColorSpaceRelease(graySpace);
    
    CGImageRef reslutRef = CGImageCreateWithMask(image.CGImage, maskRef);
    
    UIImage *result = [UIImage imageWithCGImage:reslutRef];
    CGImageRelease(reslutRef);
    CGImageRelease(maskRef);
    
    self.imageView.image = result;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
