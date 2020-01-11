//
//  RegistVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "RegistVC.h"
#import "CheckCodeVC.h"
#import "CountryCodeVC.h"

//model
#import "XWCountryModel.h"

@interface RegistVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *reLoginBtn;

@property (nonatomic, strong) XWCountryModel *countryModel;

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sendBtn.layer.cornerRadius = 6;
    self.sendBtn.enabled = NO;
    self.sendBtn.alpha = 0.5;
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
    [self.countryBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];

    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:AppLanguageStringWithKey(@"已有账号？ 登录")];
    [attstr addAttributes:@{NSForegroundColorAttributeName:kMainColor} range:[AppLanguageStringWithKey(@"已有账号？ 登录") rangeOfString:AppLanguageStringWithKey(@"登录")]];
    self.reLoginBtn.titleLabel.attributedText = attstr;
    
    [self configUI];
    [self operate];
}

- (void)configUI {
    
    if (self.type == RegistType_Phone) {
        /** 手机注册 */
        self.titleLab.text = AppLanguageStringWithKey(@"手机注册");
        self.accountTF.placeholder = AppLanguageStringWithKey(@"请输入账号");
        self.countryBtn.hidden = NO;
        [self.changeBtn setTitle:AppLanguageStringWithKey(@"切换到邮箱注册") forState:UIControlStateNormal];
    } else {
        /** 邮箱注册 */
        self.titleLab.text = AppLanguageStringWithKey(@"注册账号");
        self.accountTF.placeholder = AppLanguageStringWithKey(@"请填写邮箱");
        self.countryBtn.hidden = YES;
        [self.changeBtn setTitle:AppLanguageStringWithKey(@"切换到手机注册") forState:UIControlStateNormal];
    }
    
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.countryBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kTextBlack78,kBlackR,kBlackR) forState:UIControlStateNormal];
    
    self.accountTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.accountTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
}

- (void)operate {
    
    @weakify(self);
    [[self.changeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if ([x.currentTitle isEqualToString:AppLanguageStringWithKey(@"切换到邮箱注册")]) {
            self.type = RegistType_Email;
        } else {
            self.type = RegistType_Phone;
        }
        [self configUI];
    }];
    
    [[self.reLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.countryBtn setTitle:[NSString stringWithFormat:@"%@ +%@",self.countryModel.name,self.countryModel.tel] forState:UIControlStateNormal];
    
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
    
    /** 发送验证码 */
    RAC(self.sendBtn, enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal] reduce:^id _Nonnull(NSString *account){
        @strongify(self);
        if (account.length) {
            self.sendBtn.alpha = 1;
        } else {
            self.sendBtn.alpha = 0.5;
        }
        return @(account.length);
    }];
    [[self.sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if (!self.accountTF.text.length) {
            if (self.type==RegistType_Phone) {
                [self promptMsg:AppLanguageStringWithKey(@"请填写手机号码")];
            }
            else if (self.type==RegistType_Email) {
                [self promptMsg:AppLanguageStringWithKey(@"请填写邮箱")];
            }
        }
        else {
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"获取中")];
            [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":self.accountTF.text,@"type":@"register",@"area_code":self.countryModel.tel} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    [self promptReqSuccess:AppLanguageStringWithKey(@"验证码已发送")];
                    CheckCodeVC *code = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CheckCodeVC"];
                    code.accountStr = self.accountTF.text;
                    code.type = CodeType_Normal;
                    code.area_code = self.countryModel.tel;
                    [self.navigationController pushViewController:code animated:YES];
                }
            }];
        }
        
        
        
    }];
    
}



@end
