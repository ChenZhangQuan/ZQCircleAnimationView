//
//  ViewController.m
//  ZQAnimateCircleView
//
//  Created by 陈樟权 on 16/5/20.
//  Copyright © 2016年 陈樟权. All rights reserved.
//

#import "ViewController.h"
#import "ZQCircleAnimationView.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property(nonatomic,weak)ZQCircleAnimationView *animateView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZQCircleAnimationView *animateView = [[ZQCircleAnimationView alloc] initWithFrame:CGRectMake(0, 0, 222, 222)];
    animateView.center = CGPointMake(kDeviceWidth / 2, kDeviceHeight / 2 -200);
    animateView.backGroundView = self.view;
    
    [self.view addSubview:animateView];
    self.animateView = animateView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.animateView.score = 650;

}
@end
