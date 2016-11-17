//
//  ViewController.m
//  FYWaveView
//
//  Created by Andy on 2016/11/17.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "FYWaveView.h"
#import "Tools.h"
#import "UIImage+Color.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#define iOS9orAbove               ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define COLOR_RGB(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define COLOR_RGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//红色#FF6060
#define RED_COLOR         COLOR_RGB(255,96,96)
//中灰色#AAAAAA
#define MIDDLE_GRAY_COLOR COLOR_RGB(153, 153, 153)

//不同屏幕适配给定数字
#define FIT_CGFloat(a,b,c)    [Tools fitCGFloatFive:(a) six:(b) sixp:(c)]
//字体定义

#define FONT_BOLD(x)      [UIFont fontWithName:iOS9orAbove?@"PingFangSC-Medium":@"HelveticaNeue-Bold" size:(x)]
#define FONT_REGULAR(x)   [UIFont fontWithName:iOS9orAbove?@"PingFangSC-Regular":@"HelveticaNeue" size:(x)]
#define FONT_LIGHT(x)     [UIFont fontWithName:iOS9orAbove?@"PingFangSC-Light":@"HelveticaNeue-Light" size:(x)]
#define FONT_THIN(x)      [UIFont fontWithName:iOS9orAbove?@"PingFangSC-Thin":@"HelveticaNeue-Thin" size:(x)]

#define FIT_FONT_LIGHT(a,b,c)       FONT_LIGHT(FIT_CGFloat(a, b, c))
#define FIT_FONT_REGULAR(a,b,c)     FONT_REGULAR(FIT_CGFloat(a, b, c))
#define FIT_FONT_BOLD(a,b,c)        FONT_BOLD(FIT_CGFloat(a, b, c))
#define FIT_FONT_THIN(a,b,c)        FONT_THIN(FIT_CGFloat(a, b, c))
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"定制理财";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[FYWaveView class]]) {
            [(FYWaveView *)view startAnimation];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[FYWaveView class]]) {
            [(FYWaveView *)view stopAnimation];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews {
    
    CGFloat bottomMargin = FIT_CGFloat(30, 45, 45);
    CGFloat buttonHeight = FIT_CGFloat(50, 60, 60);
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = CGRectMake(15, self.view.bounds.size.height-bottomMargin-buttonHeight-49,
                                    self.view.bounds.size.width-30,
                                    buttonHeight);
    customButton.clipsToBounds = YES;
    customButton.layer.cornerRadius = buttonHeight/2;
    customButton.layer.borderColor = RED_COLOR.CGColor;
    customButton.layer.borderWidth = 0.5;
    customButton.titleLabel.font = FONT_LIGHT(16);
    customButton.titleEdgeInsets = UIEdgeInsetsMake(-buttonHeight/2+8, 0, 0, 0);
    [customButton setTitle:@"最优化您的银行理财收益" forState:UIControlStateNormal];
    [customButton setTitleColor:[Tools colorWithHexString:@"#FF6060"] forState:UIControlStateNormal];
    [customButton setTitleColor:[Tools colorWithHexString:@"#FF6060" alpha:0.5] forState:UIControlStateHighlighted];
    [customButton addTarget:self action:@selector(customButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    
    NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:@"最优化您的银行理财收益" attributes:@{NSForegroundColorAttributeName : RED_COLOR,NSKernAttributeName : @(4.f)}];
    [customButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight/2+2, customButton.bounds.size.width, 20)];
    tipLabel.font = FONT_LIGHT(12);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = MIDDLE_GRAY_COLOR;
    tipLabel.text = @"点击开启定制之旅";
    [customButton addSubview:tipLabel];
    //设置字间距
    attributedString =[[NSAttributedString alloc] initWithString:@"点击开启定制之旅" attributes:@{NSForegroundColorAttributeName : MIDDLE_GRAY_COLOR,NSKernAttributeName : @(4.f)}];
    
    [tipLabel setAttributedText:attributedString];
    
    CGFloat centerY = 64+(SCREEN_SIZE.height-64-49-buttonHeight-bottomMargin)/2;
    
    CGFloat d1 = FIT_CGFloat(150, 190, 210);
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-d1)/2,
                                                                  centerY-d1/2, d1, d1)];
    centerView.clipsToBounds = NO;
    centerView.layer.cornerRadius = d1/2;
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.shadowColor = COLOR_RGBA(0, 0, 0, 0.3).CGColor;
    centerView.layer.shadowOffset = CGSizeMake(0, 4);
    centerView.layer.shadowRadius = 5;
    centerView.layer.shadowOpacity = 1;
    //    [centerView.layer setMasksToBounds:YES];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [centerView addGestureRecognizer:tapGesture];
    centerView.userInteractionEnabled = YES;
    
    [self.view addSubview:centerView];
    
    //
    FYWaveView *waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#4CBED4" alpha:0.65]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#4CBED4" alpha:0.2]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#4CBED4" alpha:0.5]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#FF6060" alpha:0.1]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#FF6060" alpha:0.33]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#FF6060" alpha:1.0]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#FF9600" alpha:0.2]];
    waveView.center = centerView.center;
    
    [self.view insertSubview:waveView belowSubview:centerView];
    
    waveView = [[FYWaveView alloc] initWithRadius:d1/2 color:[Tools colorWithHexString:@"#FF9600" alpha:0.7]];
    waveView.center = centerView.center;
    [self.view insertSubview:waveView belowSubview:centerView];
    
    
    UILabel *userCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerView.bounds.size.height/2-30, centerView.bounds.size.width, 30)];
    userCountLabel.textAlignment = NSTextAlignmentCenter;
    userCountLabel.font = FONT_REGULAR(27);
    userCountLabel.textColor = RED_COLOR;
    userCountLabel.adjustsFontSizeToFitWidth = YES;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    userCountLabel.text = [formatter stringFromNumber:@(1234567)];

    [centerView addSubview:userCountLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, centerView.bounds.size.height/2+10, centerView.bounds.size.width, 25)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_LIGHT(14);
    label.textColor = COLOR_RGB(170, 170, 170);
    label.text = @"用户正在体验中";
    [centerView addSubview:label];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(centerView.frame)-26, CGRectGetMaxY(centerView.frame), 26, 26)];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 13;
    view.backgroundColor = [Tools colorWithHexString:@"#4CBED4"];
    [self.view addSubview:view];
    
    
    CGFloat d2 = FIT_CGFloat(70, 86, 96);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMinX(centerView.frame)-d2/2, CGRectGetMinY(centerView.frame)-d2-10, d2, d2);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = d2/2;
    [button setBackgroundImage:[UIImage imageWithColor:[Tools colorWithHexString:@"#FACD50"]] forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.font = FIT_FONT_REGULAR(15, 16, 16);
    [button setTitle:@"随便\n逛逛" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lookAroundButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    waveView = [[FYWaveView alloc] initWithRadius:d2/2 color:[Tools colorWithHexString:@"#FACD50" alpha:0.4] adjustSize:NO];
    waveView.center = button.center;
    [self.view insertSubview:waveView belowSubview:button];
    
    
    view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+10, CGRectGetMaxY(button.frame)-5-16, 16, 16)];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 8;
    view.backgroundColor = [Tools colorWithHexString:@"#FBEBBE"];
    [self.view addSubview:view];
    
    CGFloat d3 = FIT_CGFloat(74, 80, 90);
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(centerView.frame)-20, CGRectGetMaxY(centerView.frame)-10, d3, d3);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = d3/2;
    [button setBackgroundImage:[UIImage imageWithColor:[Tools colorWithHexString:@"#6980A2"]] forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = FONT_LIGHT(13);
    [button setTitle:@"理财精选\n推荐" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(recommendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    waveView = [[FYWaveView alloc] initWithRadius:d3/2 color:[Tools colorWithHexString:@"#6980A2" alpha:0.4] adjustSize:NO];
    waveView.center = button.center;
    [self.view insertSubview:waveView belowSubview:button];
    
    
    CGFloat d4 = FIT_CGFloat(54, 60, 70);
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMinX(centerView.frame)-d4, CGRectGetMinY(centerView.frame)-d4/2+5, d4, d4);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = d4/2;
    [button setBackgroundColor:COLOR_RGBA(76, 190, 212, .8f)];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.font = FONT_LIGHT(13);
    [button setTitle:@"猜你\n喜欢" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(guessYouLikeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    waveView = [[FYWaveView alloc] initWithRadius:d4/2 color:[Tools colorWithHexString:@"#4CBED4" alpha:0.4] adjustSize:NO];
    waveView.center = button.center;
    [self.view insertSubview:waveView belowSubview:button];
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        [self customButtonPressed:nil];
    }
}

// 定制理财
- (void)customButtonPressed:(id)sender {
   
    
}

// 随便看看
- (void)lookAroundButtonPressed:(id)sender {

}

// 理财精选推荐
- (void)recommendButtonPressed:(id)sender {

}

//猜你喜欢
-(void)guessYouLikeButtonPressed:(id)sender {

}



@end
