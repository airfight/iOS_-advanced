//
//  AppDelegate.h
//  对图层树的动画-UITabBarController
//
//  Created by zhuguangyang on 16/10/25.
//  Copyright © 2016年 Giant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) UITabBarController *tabBarController;

@end

