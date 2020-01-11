//
//  CheckCodeVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CheckCodeVC.h"
#import "SetPsdVC.h"
#import "HWTextCodeView.h"

@interface CheckCodeVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *reSendBtn;
@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

/**  */
@property (nonatomic, strong) HWTextCodeView *codeView;
@end

@implementation CheckCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.enabled = NO;
    self.nextBtn.alpha = 0.5;
    self.nextBtn.layer.cornerRadius = 6;
    
    self.topLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kTextBlack78,kBlackR,kBlackR);
    

    if (self.type == CodeType_Normal) {
        self.titleLab.text = [NSString stringWithFormat:@"%@ %@",AppLanguageStringWithKey(@"验证码已发送至"), self.accountStr];
        self.reSendBtn.hidden = NO;
        self.topLab.text = AppLanguageStringWithKey(@"输入验证码");
        self.codeView = [[HWTextCodeView alloc] initWithCount:4 margin:20];
        [self.codeView clickMaskView];
        self.codeView.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame), SCREEN_WIDTH-30, 100);
        [self.view addSubview:self.codeView];
        self.codeView.textField.secureTextEntry = NO;
    } else {
        self.codeView = [[HWTextCodeView alloc] initWithCount:6 margin:20];
        [self.codeView clickMaskView];
        self.codeView.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame), SCREEN_WIDTH-30, 100);
        [self.view addSubview:self.codeView];
        self.titleLab.text = AppLanguageStringWithKey(@"发币前需要设置支付密码");
        self.reSendBtn.hidden = YES;
        self.topLab.text = AppLanguageStringWithKey(@"设置支付密码");
        self.codeView.textField.secureTextEntry = YES;
    }
    
    
    [self operate];
    
    //开始倒计时
    [self.reSendBtn setEnabled:NO];
    [self.reSendBtn setTitle:AppLanguageStringWithKey(@"没有收到验证码，60s") forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_codeTimerAction) userInfo:nil repeats:YES];
}

- (void)operate {
    
    [[self.reSendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //发送验证码
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"发送中...")];
        [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.accountStr,@"type":@"register",@"area_code":self.area_code} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                [self promptMsg:error.localizedDescription];
            }
            else {
                [self promptReqSuccess:AppLanguageStringWithKey(@"验证码已发送")];
            }
            //开始倒计时
            [self.reSendBtn setEnabled:NO];
            [self.reSendBtn setTitle:[NSString stringWithFormat:@"%@ 60s",AppLanguageStringWithKey(@"没有收到验证码")] forState:UIControlStateNormal];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_codeTimerAction) userInfo:nil repeats:YES];
        }];
        
    }];
    
    @weakify(self);
    RAC(self.nextBtn,enabled) = [self.codeView.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (self.type==CodeType_Normal) {
            if (value.length>3) {
                self.nextBtn.alpha = 1;
            } else {
                self.nextBtn.alpha = 0.5;
            }
            return value.length>3;
        }
        else {
                
            if (value.length>5) {
                self.nextBtn.alpha = 1;
            } else {
                self.nextBtn.alpha = 0.5;
            }
            return value.length>5;
        }
    }];

    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (self.type == CodeType_Normal) {
            /** 验证码 */
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"校验中")];
            [NetWork dataTaskWithPath:@"auth/check_code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.accountStr,@"code":self.codeView.textField.text} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    
                    SetPsdVC *set = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"SetPsdVC"];
                    set.codeStr = self.codeView.textField.text;
                    set.accountStr = self.accountStr;
                    set.area_code = self.area_code;
                    [self.navigationController pushViewController:set  animated:YES];
                }
            }];
            
            
            
        } else {
            /** 注册 */
            NSDictionary *params = @{@"phone":self.accountStr,@"password":self.passwordStr,@"code":self.codeStr,@"invitation_code":self.inviteStr,@"pay_password":self.codeView.textField.text,@"area_code":self.area_code};
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"注册中")];
            [NetWork dataTaskWithPath:@"auth/register" requestMethod:NetWorkMethodPost version:1 parameters:params mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    [self promptReqSuccess:AppLanguageStringWithKey(@"注册成功")];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
            
        }
        
    }];
}

- (void)p_codeTimerAction {
    NSInteger second = [[[[self.reSendBtn titleForState:UIControlStateDisabled] componentsSeparatedByString:@"，"] lastObject] integerValue];
    if (second<=0) {
        self.reSendBtn.enabled = YES;
    }
    else {
        [self.reSendBtn setTitle:[NSString stringWithFormat:@"%@ %zds",AppLanguageStringWithKey(@"没有收到验证码"),second-=1] forState:UIControlStateDisabled];
    }
}



@end
