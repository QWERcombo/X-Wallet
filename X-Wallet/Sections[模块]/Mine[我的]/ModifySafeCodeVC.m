//
//  ModifySafeCodeVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/24.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ModifySafeCodeVC.h"

@interface ModifySafeCodeVC ()

@property (weak, nonatomic) IBOutlet UITextField *safeTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;

@end

@implementation ModifySafeCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"修改安全密码");
    [self setTheme];
    
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"获取中")];
        [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":UserData.getPhone,@"type":@"pay_password"} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                [self promptMsg:error.localizedDescription];
            }
            else {
                [self promptReqSuccess:AppLanguageStringWithKey(@"验证码已发送")];
            }
            //开始倒计时
            [self.codeBtn setEnabled:NO];
            [self.codeBtn setTitle:@"60s" forState:UIControlStateDisabled];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_codeTimerAction) userInfo:nil repeats:YES];
        }];
        
    }];
    
    RAC(self.submitBtn, enabled) = [RACSignal combineLatest:@[self.safeTF.rac_textSignal,self.codeTF.rac_textSignal,self.confirmTF.rac_textSignal] reduce:^id _Nonnull(NSString *oldPsd, NSString *codeStr,NSString *newPsd){
        
        if (oldPsd.length && codeStr.length && newPsd.length) {
            self.submitBtn.alpha = 1;
        } else {
            self.submitBtn.alpha = 0.5;
        }
        
        return @(oldPsd.length && codeStr.length && newPsd.length);
    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"提交中...")];
        [NetWork dataTaskWithPath:@"auth/change_pay_password" requestMethod:NetWorkMethodPost version:1 parameters:@{@"code":self.codeTF.text,@"pay_password":self.safeTF.text} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
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

- (void)setTheme {
    
    self.tableView.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
    self.label0.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label1.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label2.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.safeTF.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.confirmTF.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    
    [self.safeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    [self.confirmTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
}

- (void)p_codeTimerAction {
    NSInteger second = [[self.codeBtn titleForState:UIControlStateDisabled] integerValue];
    if (second<=0) {
        self.codeBtn.enabled = YES;
    }
    else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%zds",second-=1] forState:UIControlStateDisabled];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.mj_h;
}

@end
