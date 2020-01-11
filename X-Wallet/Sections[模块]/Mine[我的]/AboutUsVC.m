//
//  AboutUsVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AboutUsVC.h"
#import "UIImage+Extension.h"
#import "UpdateView.h"

@interface AboutUsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *qrImg;
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"关于我们");
    self.tableView.tableFooterView = [UIView new];
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,0x788295,kBlackR,kBlackR);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.versionLab.text = currentVersion;
    CIImage *ciimg = [UIImage creatCodeImageString:@"http://down.xwallet.vip/download/"];
    UIImage *img = [UIImage creatNonInterpolatedUIImageFormCIImage:ciimg withSize:140];
    self.qrImg.image = img;
    
//    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
//    [NetWork dataTaskWithPath:@"app_update" requestMethod:NetWorkMethodPost version:0 parameters:nil mapModelClass:nil responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        if (error) {
//            [self promptMsg:error.localizedDescription];
//        }
//        else {
//            NSString *iosVersion = responseObject[@"ios_version"];
//            if ([currentVersion compare:iosVersion]==NSOrderedAscending) {
//                //需要更新
//                [UpdateView showUpdateViewWithVersion:iosVersion content:responseObject[@"desc"] block:^{
//                    NSLog(@"update");
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:responseObject[@"ios_url"]]];
//                }];
//            }
//
//        }
//    }];

}




@end
