//
//  SetOrderVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "SetOrderVC.h"
#import "OrderSubVC.h"
#import "DiscoverBLL.h"
#import "XWCountryModel.h"

@interface SetOrderVC ()<OrderSubVCDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) OrderSubVC *subVC;

@end

@implementation SetOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"结算");
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (!self.subVC.shouhuorenTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入收货人")];
            return ;
        }
        if (!self.subVC.countryModel) {
            [self promptMsg:AppLanguageStringWithKey(@"请选择地区")];
            return ;
        }
        if (!self.subVC.phoneTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入收货人手机号码")];
            return ;
        }
        if (!self.subVC.addressTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入详细地址")];
            return ;
        }
        if (!self.subVC.codeTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入邮政编码")];
            return ;
        }
        
        [self showTextFieldAlertWithHandler:^(NSString * _Nonnull psd) {
            
            [self loading];
            [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{@"name":self.subVC.shouhuorenTF.text,@"mobile":self.subVC.phoneTF.text,@"detail":self.subVC.addressTF.text,@"post_code":self.subVC.codeTF.text,@"goods_id":self.shopDic[@"id"],@"goods_number":[NSString stringWithFormat:@"%ld",self.count],@"currency_id":self.currency[@"id"],@"pay_password":psd,@"area_code":self.subVC.countryModel.tel} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"shop/orderBuy" onSuccess:^(NSDictionary * _Nonnull resultDic) {
                [self hideLoading];
                
                [self promptReqSuccess:resultDic[@"data"] promptCompletion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } onNetWorkFail:^(NSString * _Nonnull msg) {
                [self promptMsg:msg];
            } onRequestTimeOut:^{
                [self promptRequestTimeOut];
            }];
            
        }];
        
    }];
    
}
- (void)refrenTotalMoney:(NSString *)moneyStr {
    self.moneyLab.text = [NSString stringWithFormat:@"≈%@", moneyStr];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"subVC"]) {
        
        self.subVC = segue.destinationViewController;
        self.subVC.delegate = self;
        self.subVC.shopDic = self.shopDic;
        self.subVC.count = self.count;
        self.subVC.size = self.size;
        self.subVC.currency = self.currency;
    }
    
}


@end
