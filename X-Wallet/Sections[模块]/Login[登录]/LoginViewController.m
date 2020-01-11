//
//  LoginViewController.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//  @"placeholderLabel.textColor"

#import "LoginViewController.h"
#import "RegistVC.h"
#import "ForgetPsdVC.h"
#import "CountryCodeVC.h"

//model
#import "XWCountryModel.h"
#import "UserData.h"
//views
#import "NNValidationView.h"
#import "YBPopupMenu.h"
//vc
#import "AppDelegate.h"

@interface LoginViewController ()<YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UIButton *languageBtn;
@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
//@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *imageCodeView;
@property (nonatomic, strong) NNValidationView *captcharView;

@property (nonatomic, strong) NSString *codeStr;

@property (nonatomic, assign) RegistType type;

@property (nonatomic, strong) XWCountryModel *countryModel;

@property (nonatomic, assign) NSInteger languageIndex;

@end

@implementation LoginViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self p_showUpdateView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.languageBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    self.type = RegistType_Phone;
    self.loginBtn.enabled = NO;
    self.loginBtn.alpha = 0.5;
    self.loginBtn.layer.cornerRadius = 6;
    self.countryModel = [[XWCountryModel alloc] init];
    if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageChineseKey]) {
        self.countryModel.tel = @"86";
        self.countryModel.name = @"中国";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageJapaneseKey]) {
        self.countryModel.tel = @"81";
        self.countryModel.name = @"Japan";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageKoreanKey]) {
        self.countryModel.tel = @"850";
        self.countryModel.name = @"NorthKorea";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageEnglishKey]) {
        self.countryModel.tel = @"1";
        self.countryModel.name = @"UnitedStatesofAmerica";
    }
    
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:AppLanguageStringWithKey(@"还没有账号？ 注册")];
    [attstr addAttributes:@{NSForegroundColorAttributeName:kMainColor} range:[self.registBtn.currentTitle rangeOfString:AppLanguageStringWithKey(@"注册")]];
    self.registBtn.titleLabel.attributedText = attstr;
    
    [self operate];
    
    self.captcharView = [[NNValidationView alloc] initWithFrame:CGRectMake(0, 0, 80.0, 35.0) andCharCount:4 andLineCount:4];
    [self.imageCodeView addSubview:self.captcharView];
    
    [_captcharView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self setTheme];
}

- (void)operate {
    
    @weakify(self);
    /** 语言 */
    [[self.languageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        NSLog(@"--%@", x.currentTitle);
        [YBPopupMenu showRelyOnView:self.languageBtn titles:@[@"中文",@"English",@"日本語",@"한글"] icons:nil menuWidth:120.0 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.delegate = self;
        }];
        
    }];
    
    
    [self.countryBtn setTitle:[NSString stringWithFormat:@"%@ +%@",self.countryModel.name,self.countryModel.tel] forState:UIControlStateNormal];
    [self.countryBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
    /** 区号 */
    [[self.countryBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        CountryCodeVC *country = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CountryCodeVC"];
        
        [country setValueBlock:^(XWCountryModel * _Nonnull value) {
            
            self.countryModel = value;
            [x setTitle:[NSString stringWithFormat:@"%@ +%@",value.name,value.tel] forState:UIControlStateNormal];
            [self.countryBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];

        }];
        [self.navigationController pushViewController:country animated:YES];
    }];
    
    
    //点击刷新
    self.captcharView.changeValidationCodeBlock = ^(NSString *codeString) {
        
    };
    
//    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        if (!self.phoneTF.text.length) {
//            if (self.type==RegistType_Phone) {
//                [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
//            }
//            else if (self.type==RegistType_Email) {
//                [SVProgressHUD showErrorWithStatus:@"请填写邮箱"];
//            }
//
//        }
//        else {
//            [SVProgressHUD showWithStatus:@"获取中..."];
//            [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.phoneTF.text,@"type":@"login"} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
//                [SVProgressHUD dismiss];
//                if (error) {
//                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
//                }
//                else {
//                    [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
//                }
//                //开始倒计时
//                [self.codeBtn setEnabled:NO];
//                [self.codeBtn setTitle:@"60s" forState:UIControlStateDisabled];
//                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_codeTimerAction) userInfo:nil repeats:YES];
//            }];
//        }
//
//    }];
    
    /** 切换邮箱 */
    [[self.emailBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if ([x.currentTitle isEqualToString:AppLanguageStringWithKey(@"切换到邮箱")]) {
            self.titleLab.text = AppLanguageStringWithKey(@"邮箱登录");
            self.phoneTF.placeholder = AppLanguageStringWithKey(@"请填写邮箱");
            self.phoneTF.keyboardType = UIKeyboardTypeEmailAddress;
            self.countryBtn.hidden = YES;
            self.type = RegistType_Phone;
            [self.emailBtn setTitle:AppLanguageStringWithKey(@"切换到手机号") forState:UIControlStateNormal];
        } else {
            self.titleLab.text = AppLanguageStringWithKey(@"X-WALLET登录");
            self.phoneTF.placeholder = AppLanguageStringWithKey(@"请填写手机号");
            self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
            self.countryBtn.hidden = NO;
            self.type = RegistType_Email;
            [self.emailBtn setTitle:AppLanguageStringWithKey(@"切换到邮箱") forState:UIControlStateNormal];
        }
    }];
    
    /** 忘记密码 */
    [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        ForgetPsdVC *forget = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgetPsdVC"];
        [self.navigationController pushViewController:forget animated:YES];
    }];
    
    /** 注册 */
    [[self.registBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        RegistVC *regist = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"RegistVC"];
        regist.type = RegistType_Phone;
        [self.navigationController pushViewController:regist animated:YES];
    }];
    
    /** 登录 */
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[self.phoneTF.rac_textSignal,self.psdTF.rac_textSignal,self.codeTF.rac_textSignal] reduce:^id _Nonnull(NSString *phone, NSString *psd, NSString *code){
        @strongify(self);
        if (phone.length && psd.length && code.length) {
            self.loginBtn.alpha = 1.0;
        } else {
            self.loginBtn.alpha = 0.5;
        }
        return @(phone.length && psd.length && code.length);
    }];
    
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        
        if (![[self.captcharView.charString uppercaseString] isEqualToString:[self.codeTF.text uppercaseString]]) {
            [self promptMsg:AppLanguageStringWithKey(@"请填写正确的验证码")];
            [self.captcharView changeCode];
        }
        else {
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"登录中")];
            [NetWork dataTaskWithPath:@"auth/login" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.phoneTF.text,@"password":self.psdTF.text} mapModelClass:nil responsePath:kWXNetWorkResponsePath completionHandler:^(id responseObject, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                    [self.captcharView changeCode];
                }
                else {
                    //
                    [UserData savePhone:self.phoneTF.text];
                    [self completeLoginWithToken:responseObject[@"token"]];
                }
            }];
        }
        
        

        
    }];
    
}

#pragma mark - YBPopupMenuDelegate

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    kAppLanguageKey languageKey = nil;
    if (index==0) {
        languageKey = kAppLanguageChineseKey;
    }
    else if (index==1) {
        languageKey = kAppLanguageEnglishKey;
    }
    else if (index==2) {
        languageKey = kAppLanguageJapaneseKey;
    }
    else if (index==3) {
        languageKey = kAppLanguageKoreanKey;
    }
    if (languageKey.length) {
        [[AppLanguageManager shareManager] setLanguage:languageKey];
        AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
        [appDelegate setRootViewController];
    }

}

//- (void)p_codeTimerAction {
//    NSInteger second = [[self.codeBtn titleForState:UIControlStateDisabled] integerValue];
//    if (second<=0) {
//        self.codeBtn.enabled = YES;
//    }
//    else {
//        [self.codeBtn setTitle:[NSString stringWithFormat:@"%zds",second-=1] forState:UIControlStateDisabled];
//    }
//}
- (void)setTheme {
    
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR);
    [self.countryBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kTextBlack78,kBlackR) forState:UIControlStateNormal];
    
    self.phoneTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR);
    [self.phoneTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.psdTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR);
    [self.psdTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR);
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
}

@end
