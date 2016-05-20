//
//  ZQCircleAnimationView.m
//  ZQCircleAnimationView
//
//  Created by 陈樟权 on 16/4/30.
//  Copyright © 2016年 陈樟权. All rights reserved.
//

#import "ZQCircleAnimationView.h"
#import "UIView+Extension.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define kAnimationTime 2.0
#define kMinScore 350.0
#define kMaxScore 950.0

@interface ZQCircleAnimationView()


//底部表盘view
@property(nonatomic,weak)UIImageView *plateView;
//颜色变化的view
@property(nonatomic,strong)CAGradientLayer *bottomLayer;
//运动的弧线layer
@property(nonatomic,weak)CAShapeLayer *backLayer;

//时间label
@property(nonatomic,weak)UILabel *timeLabel;
//等级label
@property(nonatomic,weak)UILabel *levLabel;
//数字label
@property(nonatomic,weak)UILabel *numLabel;

//当前percent
@property(nonatomic,assign)CGFloat currentPercent;
//当前需要走的percent
@property(nonatomic,assign)CGFloat percent;




//加数字用的当前分数，和目标分数
@property(nonatomic,assign)CGFloat targetScore;
@property(nonatomic,assign)CGFloat currentScore;


@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@end

@implementation ZQCircleAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

            
        
        

        self.stareAngle = -202.5f;
        self.endAngle = 22.5f;

        
        UIImageView *plateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borrowBackground"]];
        plateView.frame = CGRectMake(0, 15, 469 / 2 * 1.3, 331 / 2 * 1.3);
        plateView.centerX = self.centerX;
        [self addSubview:plateView];
        self.plateView = plateView;
        
        //*****
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2 + 6 + 50) radius:(437.5 / 4 - 2) * 1.3 startAngle:degreesToRadians(self.stareAngle) endAngle:degreesToRadians(self.endAngle) clockwise:YES];
        
        CAShapeLayer *backLayer = [[CAShapeLayer alloc] init];
        backLayer.frame = self.bounds;
        backLayer.fillColor = [[UIColor clearColor] CGColor];
        backLayer.strokeColor = [[UIColor  whiteColor] CGColor];
        backLayer.path = [path CGPath];
        backLayer.lineWidth = 7.5f * 1.3;
        backLayer.strokeEnd = 0;
        backLayer.shadowColor = [UIColor blackColor].CGColor;
        backLayer.shadowOffset = CGSizeMake(-2, 0);
        backLayer.shadowRadius = 2;
        backLayer.shadowOpacity = 0.2;
        [self.layer addSublayer:backLayer];
        self.backLayer = backLayer;
        //*****
        
        
        UILabel *numLabel = [[UILabel alloc] init];
        
        self.numLabel = numLabel;
        numLabel.text = [NSString stringWithFormat:@"%.0f", kMinScore];
        numLabel.textColor = UIColorFromRGB(0xffd56b);
        numLabel.font = [UIFont systemFontOfSize:70];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.frame = CGRectMake(0, 0, 200, 100);
        numLabel.center = CGPointMake(self.width / 2, self.height / 2 - 5 + 50);
        [self addSubview:numLabel];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"评估时间:0000 00 00";
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.alpha = 0.5;
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.frame = CGRectMake(0, 0, 250, 100);
        timeLabel.center = CGPointMake(self.width / 2, self.height / 2 + 25 + 60 );
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *levLabel = [[UILabel alloc] init];
        levLabel.text = @"0";
        levLabel.textColor = [UIColor whiteColor];
        levLabel.font = [UIFont systemFontOfSize:25];
        levLabel.textAlignment = NSTextAlignmentCenter;
        levLabel.frame = CGRectMake(0, 0, 250, 100);
        levLabel.center = CGPointMake(self.width / 2, self.height / 2 + 55 + 60);
        [self addSubview:levLabel];
        self.levLabel = levLabel;
        UILabel *levTextLabel = [[UILabel alloc] init];
        levTextLabel.text = @"可借额度(元)";
        levTextLabel.textColor = [UIColor whiteColor];
        levTextLabel.alpha = 0.5;
        levTextLabel.font = [UIFont systemFontOfSize:11];
        levTextLabel.textAlignment = NSTextAlignmentCenter;
        levTextLabel.frame = CGRectMake(0, 0, 250, 100);
        levTextLabel.center = CGPointMake(self.width / 2, self.height / 2 + 75 + 60);
        [self addSubview:levTextLabel];
        
        
        
        
    }
    return self;
}
-(void)configUI{


    
    
    
    
    
    
    
}

-(void)setScore:(NSInteger)score{
    _score = score;
    
    CGFloat percent = 0.0;
    if (score > 350 && score <= 550) {
        
        percent = (score - 350) / 1000.0 * 100;
        
    }else if (score > 550 && score <= 700) {
        
        percent = 20 + (score - 550) / 250.0 * 100;
        
    }else if (score > 700 && score <= 950) {
        
        percent = 80 + (score - 700) / 1250.0 * 100;
        
    }
    
    self.percent = percent;
    
    [self startBackAnimate];
    


    
    self.currentPercent = -1;
    
    [self changeColor2];
    
    
    self.targetScore = _score;
    self.currentScore = kMinScore;
    self.numLabel.text = [NSString stringWithFormat:@"%.0f",kMinScore];
    
    [self addTextLabel];
    
}

-(void)startBackAnimate{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @(self.percent / 100.0);
    animation.duration = self.percent / 100.0 * kAnimationTime;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.backLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
}

-(void)changeColor2{
    
    if (self.currentPercent >= self.percent) {
        return;
    }
    
    CGFloat perPercent = 2;
    self.currentPercent += perPercent;
    
    CGFloat colorH;
    CGFloat colorS;
    CGFloat colorB;
    CGFloat offsetH;
    
    if  (self.currentPercent <= 19.0){
        colorH = 0 + 37 / 19.0 * self.currentPercent;
        colorS = 0.70;
    }else if (self.currentPercent <= 20.8){
        colorH = 37 + (100 - 37) / (20.8 - 19.0) * (self.currentPercent - 19.0);
        colorS = 0.65;
    }else if (self.currentPercent <= 30.0){
        colorH = 100 + (120 - 100) / (30.0 - 20.8) * (self.currentPercent - 20.8);
        colorS = 0.60;
    }else if (self.currentPercent <= 40.0){
        colorH = 120;
        colorS = 0.60;

    }else if (self.currentPercent <= 70.0){
        colorH = 120 + (360 - 120) / 60.0 * (self.currentPercent - 40.0);
        colorS = 0.60;

    }else{
        colorH = 240;
        colorS = 0.90;
    }
    
    if  (self.currentPercent <= 17.0){
        colorB = 0.92;
    }else if (self.currentPercent <= 19.0){
        colorB = 0.85;
    }else if (self.currentPercent <= 30.0){
        colorB = 0.70;

    }else if (self.currentPercent <= 40.0){
        colorB = 0.74;

    }else if (self.currentPercent <= 70.0){
        colorB = 0.74;

    }else{
        colorB = 0.95;

    }
    
    if  (self.currentPercent <= 17.0){
        offsetH = 12;
    }else if (self.currentPercent <= 19.5){
        offsetH = 5;
    }else if (self.currentPercent <= 20.5){
        offsetH = -5;
    }else if (self.currentPercent <= 45.0){
        offsetH = -30;
    }else{
        offsetH = -20;

    }


    
    
    UIColor *color1 = [UIColor colorWithHue:colorH / 360.0
                                 saturation:colorS
                                 brightness:colorB
                                      alpha:1.0];


    UIColor *color2 = [UIColor colorWithHue:(colorH + offsetH) / 360.0
                                 saturation:colorS
                                 brightness:colorB
                                      alpha:1.0];

    self.bottomLayer.colors = @[(id)color1.CGColor,(id)color2.CGColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.04 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeColor2];
    });
}

-(void)addTextLabel{
    
    if (self.currentScore + 0.5 >= self.targetScore) {
        return;
    }
    CGFloat perScore = (self.targetScore - kMinScore) / 50.0;
    self.currentScore += perScore;
    self.numLabel.text = [NSString stringWithFormat:@"%.0f",self.currentScore];
    NSTimeInterval interval = (kAnimationTime * self.percent / 100) / 50;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTextLabel];
    });
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    CAGradientLayer *bottomLayer = [[CAGradientLayer alloc] init];
    bottomLayer.anchorPoint = CGPointMake(0, 0);
    bottomLayer.bounds = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    [bottomLayer setStartPoint:CGPointMake(0, 0)];
    [bottomLayer setEndPoint:CGPointMake(0, 1)];
    self.bottomLayer = bottomLayer;
    [self.backGroundView.layer insertSublayer:bottomLayer atIndex:0];
    
    self.score = 350;
    
}



@end
