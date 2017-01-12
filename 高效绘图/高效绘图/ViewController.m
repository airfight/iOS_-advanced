//
//  ViewController.m
//  高效绘图
//
//  Created by zhuguangyang on 2017/1/11.
//  Copyright © 2017年 GYJade. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"
#import "YYFPSLabel.h"
#import "GYDrawingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    DrawingView *drawView = [[DrawingView alloc] init];
    drawView.frame = self.view.frame;
    drawView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:drawView];
#endif
    
    GYDrawingView *gydrawView = [[GYDrawingView alloc] init];
    gydrawView.frame = self.view.frame;
    gydrawView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:gydrawView];
    
    
    YYFPSLabel *yyLb = [[YYFPSLabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-60, CGRectGetHeight(self.view.frame)-30, 60, 30)];
    [self.navigationController.view addSubview:yyLb];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
