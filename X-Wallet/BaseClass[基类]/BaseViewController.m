//
//  DDBaseViewController.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rt_disableInteractivePop = NO;
    self.view.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    
    [self addViewEndEditTap];
    [self configurateNavigationBarSetting];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Night"]) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImagePicker:IXImagePickerWithImages([UIImage imageNamed:@"navi_back_black"],[UIImage imageNamed:@"public_white_back"],[UIImage imageNamed:@"navi_back_black"],[UIImage imageNamed:@"navi_back_black"]) forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configurateNavigationBarSetting {
    
    self.rt_disableInteractivePop = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold], NSForegroundColorAttributeName:[UIColor barColror]}];

    self.navigationController.navigationBar.barTintColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
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
