//
//  OrderSubVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "OrderSubVC.h"
#import "CountryCodeVC.h"
#import "XWCountryModel.h"

@interface OrderSubVC ()

@property (weak, nonatomic) IBOutlet UIImageView *shop_img;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *shop_price;
@property (weak, nonatomic) IBOutlet UILabel *shop_count;
@property (weak, nonatomic) IBOutlet UITextField *liuyanTF;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLab;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view0;

@end

@implementation OrderSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.label4.text = AppLanguageStringWithKey(@"地区");
    [self.countryBtn setTitle:AppLanguageStringWithKey(@"请选择地区") forState:UIControlStateNormal];
    @weakify(self);
    [[self.countryBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        CountryCodeVC *country = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CountryCodeVC"];
        
        [country setValueBlock:^(XWCountryModel * _Nonnull value) {
            
            self.countryModel = value;
            [x setTitle:value.name forState:UIControlStateNormal];

        }];
        country.isHideCode = YES;
        [self.navigationController pushViewController:country animated:YES];
    }];
    
    [self setTheme];
    
    [self.shop_img sd_setImageWithURL:[NSURL URLWithString:[self.shopDic[@"image"] stringByReplacingOccurrencesOfString:@"," withString:@""]]];
    self.shop_name.text = [NSString stringWithFormat:@"%@",self.shopDic[@"title"]];
    self.shop_count.text = [NSString stringWithFormat:@"x%ld", self.count];
    self.shop_price.text = [NSString stringWithFormat:@"$%@",self.shopDic[@"price"]];
    self.moneyLab.text = [NSString stringWithFormat:@"≈%f%@", ([self.shopDic[@"price"] floatValue]/[self.currency[@"usdt_price"] floatValue]*self.count),self.currency[@"name"]];
    self.yunfeiLab.text = [NSString stringWithFormat:@"$%@",self.shopDic[@"freight"]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(refrenTotalMoney:)]) {
        [self.delegate refrenTotalMoney:[NSString stringWithFormat:@"%f%@",(([self.shopDic[@"price"] floatValue]+[self.shopDic[@"freight"] floatValue])/[self.currency[@"usdt_price"] floatValue]*self.count),self.currency[@"name"]]];
    }
}


- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label3.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label4.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label5.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label6.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label7.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shop_price.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shop_name.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shop_count.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.moneyLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.yunfeiLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.shouhuorenTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.shouhuorenTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.phoneTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.phoneTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.addressTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.addressTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.liuyanTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.liuyanTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
}


@end
