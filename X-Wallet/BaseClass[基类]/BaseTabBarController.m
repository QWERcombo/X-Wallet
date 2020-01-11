//
//  DDBaseTabBarController.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "AssetViewController.h"
#import "QuotationViewController.h"
#import "DiscoverViewController.h"
#import "InfomationViewController.h"
#import "MineViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.translucent = NO;
        self.tabBar.barTintColor = [UIColor redColor];
        self.tabBar.barTintColorPicker = IXColorPickerWithRGB(kWhiteR,kTabBarRN,kWhiteR,kWhiteR);
        
        // 通过appearance统一设置UITabbarItem的文字属性
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        attrs[NSForegroundColorAttributeName] = TABBAR_TITLE_UNSELECT;

        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = TABBAR_TITLE_SELECT;

        UITabBarItem * item = [UITabBarItem appearance];
        // 设置appearance
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        AssetViewController *home = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"AssetViewController"];
        home.tabBarItem.selectedImagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_asset_select"],[UIImage imageNamed:@"tab_asset_select"],[UIImage imageNamed:@"tab_asset_selectC"],[UIImage imageNamed:@"tab_asset_selectNY"]);
        home.tabBarItem.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_asset_unselect"],[UIImage imageNamed:@"tab_asset_unselectN"],[UIImage imageNamed:@"tab_asset_unselect"],[UIImage imageNamed:@"tab_asset_unselect"]);
        [home.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [home.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        home.tabBarItem.tag = 101;
        BaseNavigationController *homeNavi = [[BaseNavigationController alloc] initWithRootViewController:home];
        homeNavi.tabBarItem.title = AppLanguageStringWithKey(@"资产");
        home.title = homeNavi.tabBarItem.title;
        [self addChildViewController:homeNavi];
        
        
        QuotationViewController *service = [[UIStoryboard storyboardWithName:@"Quotation" bundle:nil] instantiateViewControllerWithIdentifier:@"QuotationViewController"];
        service.tabBarItem.selectedImagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_quo_select"],[UIImage imageNamed:@"tab_quo_select"],[UIImage imageNamed:@"tab_quo_selectC"],[UIImage imageNamed:@"tab_quo_selectNY"]);
        service.tabBarItem.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_quo_unselect"],[UIImage imageNamed:@"tab_quo_unselectN"],[UIImage imageNamed:@"tab_quo_unselect"],[UIImage imageNamed:@"tab_quo_unselect"]);
        [service.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [service.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        service.tabBarItem.tag = 102;
        BaseNavigationController *serviceNavi = [[BaseNavigationController alloc] initWithRootViewController:service];
        service.title = service.tabBarItem.title;
        serviceNavi.tabBarItem.title = AppLanguageStringWithKey(@"行情");
        service.title = serviceNavi.tabBarItem.title;
        [self addChildViewController:serviceNavi];
        
        
        DiscoverViewController *intelligent = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"DiscoverViewController"];
        intelligent.tabBarItem.selectedImagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_dis_select"],[UIImage imageNamed:@"tab_dis_select"],[UIImage imageNamed:@"tab_dis_selectC"],[UIImage imageNamed:@"tab_dis_selectNY"]);
        intelligent.tabBarItem.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_dis_unselect"],[UIImage imageNamed:@"tab_dis_unselectN"],[UIImage imageNamed:@"tab_dis_unselect"],[UIImage imageNamed:@"tab_dis_unselect"]);
        [intelligent.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [intelligent.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        intelligent.tabBarItem.tag = 103;
        BaseNavigationController *intelligentNavi = [[BaseNavigationController alloc] initWithRootViewController:intelligent];
        intelligentNavi.tabBarItem.title = AppLanguageStringWithKey(@"发现");
        intelligent.title = intelligentNavi.tabBarItem.title;
        [self addChildViewController:intelligentNavi];
        
        
        InfomationViewController *infomation = [[UIStoryboard storyboardWithName:@"Infomation" bundle:nil] instantiateViewControllerWithIdentifier:@"InfomationViewController"];
        infomation.tabBarItem.selectedImagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_inf_select"],[UIImage imageNamed:@"tab_inf_select"],[UIImage imageNamed:@"tab_inf_selectC"],[UIImage imageNamed:@"tab_inf_selectNY"]);
        infomation.tabBarItem.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_inf_unselect"],[UIImage imageNamed:@"tab_inf_unselectN"],[UIImage imageNamed:@"tab_inf_unselect"],[UIImage imageNamed:@"tab_inf_unselect"]);
        [infomation.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [infomation.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        infomation.tabBarItem.tag = 104;
        BaseNavigationController *infomationNavi = [[BaseNavigationController alloc] initWithRootViewController:infomation];
        infomationNavi.tabBarItem.title = AppLanguageStringWithKey(@"资讯");
        infomation.title = infomationNavi.tabBarItem.title;
        [self addChildViewController:infomationNavi];
        
        
        MineViewController *me = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MineViewController"];
        me.tabBarItem.selectedImagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_me_select"],[UIImage imageNamed:@"tab_me_select"],[UIImage imageNamed:@"tab_me_selectC"],[UIImage imageNamed:@"tab_me_selectNY"]);
        me.tabBarItem.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"tab_me_unselect"],[UIImage imageNamed:@"tab_me_unselectN"],[UIImage imageNamed:@"tab_me_unselect"],[UIImage imageNamed:@"tab_me_unselect"]);
        [me.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [me.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        me.tabBarItem.tag = 105;
        BaseNavigationController *meNavi = [[BaseNavigationController alloc] initWithRootViewController:me];
        meNavi.tabBarItem.title = AppLanguageStringWithKey(@"我的");
        me.title = meNavi.tabBarItem.title;
        [self addChildViewController:meNavi];
        
        self.tabBar.unselectedItemTintColorPicker = IXColorPickerWithRGB(kTabBarUns,kTabBarUnsN,kTabBarUns,kTabBarUns);
        self.tabBar.tintColorPicker = IXColorPickerWithRGB(kMainColorR,kMainColorR,kMainColorR,kMainColorR);
    }
    return self;
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    
    return YES;
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
