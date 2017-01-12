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

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIScrollView *scrollView;


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
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
//    [self.view addSubview:_tableView];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:_scrollView];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;

    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
    
    //log
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];

    UIView *view = [[UIView alloc] init];
#if 0
    
    view.frame = cell.frame;
    view.layer.cornerRadius = 20;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor redColor];
#endif
#if 1
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = cell.frame;
    blueLayer.fillColor = [UIColor blueColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:
                          CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame)) cornerRadius:20].CGPath;
        
    [view.layer addSublayer:blueLayer];
#endif
    [cell.contentView addSubview:view];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
