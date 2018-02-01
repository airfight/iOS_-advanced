//
//  TimerVc.m
//  OCThread
//
//  Created by ZGY on 2018/1/4.
//Copyright © 2018年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2018/1/4  下午12:56
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "TimerVc.h"
#import "GYWeakProxy.h"
// Controllers

// Model

// Views

//#define <#macro#> <#value#>

@interface TimerVc ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation TimerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    GYWeakProxy *PROXY = [GYWeakProxy proxyWithTarget:self];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:PROXY selector:@selector(run) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    [self performSelector:@selector(invalide) withObject:nil afterDelay:3];
    
}

- (void)run
{
    NSLog(@"run");
}

- (void)invalide
{
    [_timer invalidate];
    _timer = nil;
}
- (void)dealloc
{

    [_timer invalidate];
    _timer = nil;
}



#pragma mark - Override


#pragma mark - Initial Methods


#pragma mark - Delegate


#pragma mark - Target Methods


#pragma mark - Notification Methods


#pragma mark - KVO Methods


#pragma mark - UITableViewDelegate, UITableViewDataSource


#pragma mark - Privater Methods


#pragma mark - Setter Getter Methods


#pragma mark - Life cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
