//
//  ModifyNickNameVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/24.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ModifyNickNameVC.h"

@interface ModifyNickNameVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *label0;

@end

@implementation ModifyNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"修改昵称");
    self.inputTF.layer.cornerRadius = 6;
    self.inputTF.text = self.nickName;
    self.view.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
    self.label0.textColorPicker = IXColorPickerWithRGB(kTabBarUns,kWhiteR,kTabBarUns,kTabBarUns);
    self.inputTF.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.inputTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    @weakify(self);
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"提交中")];
        [NetWork dataTaskWithPath:@"auth/changeInfo" requestMethod:NetWorkMethodPost version:1 parameters:@{@"type":@"nickname",@"value":self.inputTF.text} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                [self promptMsg:error.localizedDescription];
            }
            else {
                [self promptReqSuccess:AppLanguageStringWithKey(@"修改成功")];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }];
        
}


@end
