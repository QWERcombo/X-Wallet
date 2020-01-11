//
//  ForgetPsdVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ForgetPsdVC.h"

@interface ForgetPsdVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;
@property (weak, nonatomic) IBOutlet UITextField *payPsdTF;
@property (weak, nonatomic) IBOutlet UITextField *rePayPsdTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn1;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn2;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *label0;


@end

@implementation ForgetPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.doneBtn.layer.cornerRadius = 6;
    self.doneBtn.enabled = NO;
    self.doneBtn.alpha = 0.5;
    self.hideBtn1.selected = NO;
    self.hideBtn2.selected = NO;
    [self setTheme];
    
    @weakify(self);
    /** 获取验证码 */
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        
        @strongify(self);
        if (!self.phoneTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入手机或邮箱")];
        }
        else {
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"获取中")];
            [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.phoneTF.text,@"type":@"find"} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
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
        }
            
    }];
    
    [[self.hideBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        self.hideBtn1.selected = !self.hideBtn1.selected;
        self.psdTF.secureTextEntry = !self.hideBtn1.selected;
    }];
    [[self.hideBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        self.hideBtn2.selected = !self.hideBtn2.selected;
        self.confirmTF.secureTextEntry = !self.hideBtn2.selected;
    }];
    
    
    /** 找回密码 */
    RAC(self.doneBtn, enabled) = [RACSignal combineLatest:@[self.phoneTF.rac_textSignal,self.codeTF.rac_textSignal,self.psdTF.rac_textSignal,self.confirmTF.rac_textSignal,self.payPsdTF.rac_textSignal,self.rePayPsdTF.rac_textSignal] reduce:^id _Nonnull(NSString *phone, NSString *code, NSString *psd, NSString *confirm, NSString *payPsd, NSString *rePayPsd){
        @strongify(self);
        if (phone.length && code.length && psd.length && confirm.length && [psd isEqualToString:confirm] && payPsd.length && rePayPsd.length && [payPsd isEqualToString:rePayPsd]) {
            self.doneBtn.alpha = 1;
        } else {
            self.doneBtn.alpha = 0.5;
        }
        
        return @(phone.length && code.length && psd.length && confirm.length && [psd isEqualToString:confirm] && payPsd.length && rePayPsd.length && [payPsd isEqualToString:rePayPsd]);
    }];
    
    
    [[self.doneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"提交中")];
        [NetWork dataTaskWithPath:@"auth/findPassword" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.phoneTF.text,@"password":self.psdTF.text,@"code":self.codeTF.text,@"pay_password":self.payPsdTF.text} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                [self promptMsg:error.localizedDescription];
            }
            else {
                [self promptReqSuccess:AppLanguageStringWithKey(@"找回成功")];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        
        
    }];
}

#pragma mark - Table view data source

- (void)p_codeTimerAction {
    NSInteger second = [[self.codeBtn titleForState:UIControlStateDisabled] integerValue];
    if (second<=0) {
        self.codeBtn.enabled = YES;
    }
    else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%zds",second-=1] forState:UIControlStateDisabled];
    }
}


- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self.phoneTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.phoneTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self.psdTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.psdTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self.payPsdTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.payPsdTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self.rePayPsdTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.rePayPsdTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.confirmTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.confirmTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
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
