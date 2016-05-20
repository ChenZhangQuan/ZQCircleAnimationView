//
//  ZQCircleAnimationView.h
//  ZQCircleAnimationView
//
//  Created by 陈樟权 on 16/4/30.
//  Copyright © 2016年 陈樟权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQCircleAnimationView : UIView


//在哪个view里面加上颜色变化的view
@property(nonatomic,weak)UIView *backGroundView;
//分数
@property(nonatomic,assign)NSInteger score;

@end
