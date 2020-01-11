//
//  ShopDetailVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopDetailVC.h"
#import "SetOrderVC.h"
#import "DiscoverBLL.h"
#import "DCCycleScrollView.h"
#import "ShopChooseSizeView.h"
#import "MyOrderVC.h"
#import "HYStepper.h"

@interface ShopDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
@property (weak, nonatomic) IBOutlet UILabel *shopDes;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *shopCount;
@property (weak, nonatomic) IBOutlet UILabel *shopTrans;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet HYStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ShopDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.navigationController.navigationBarHidden = YES;
    self.stepper.maxValue = 99;
    
    @weakify(self);
    [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.stepper setValueChanged:^(double value) {
        self.count = value;
    }];
    
    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (self.count==0) {
            [self promptMsg:AppLanguageStringWithKey(@"请先选择规格")];
            return ;
        }
        if (!self.selectBtn) {
            [self promptMsg:AppLanguageStringWithKey(@"请先选择支付方式")];
            return;
        }
        
        SetOrderVC *order = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"SetOrderVC"];
        order.shopDic = self.dataDic;
        order.count = self.count;
        for (NSDictionary *dic in self.dataDic[@"buy_list"]) {
            if ([dic[@"name"] isEqualToString:self.selectBtn.currentTitle]) {
                order.currency = dic;
                break;
            }
        }
        [self.navigationController pushViewController:order animated:YES];
    }];
    
    [self.orderBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [[self.orderBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        MyOrderVC *vc = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MyOrderVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [self setTheme];
    [self getDetailData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    blankView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    label.text = AppLanguageStringWithKey(@"支付方式");
    label.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [blankView addSubview:label];
    
    if (self.dataDic) {
        
        NSArray *arr = self.dataDic[@"buy_list"];
        for (int i=0; i<arr.count; i++) {
            
            UIButton *button = [self getItemButtonWithTitle:arr[i][@"name"]];
            button.frame = CGRectMake((90*i)+15, 45, 75, 30);
            [blankView addSubview:button];
        }
        
    }
    
    return blankView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}


- (UIButton *)getItemButtonWithTitle:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    button.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 15;
    button.layer.borderColor = kMainText9Color.CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if (x!= self.selectBtn) {
            
            self.selectBtn.selected = NO;
            self.selectBtn.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
            self.selectBtn.layer.borderWidth = 1;
            self.selectBtn.layer.cornerRadius = 15;
            self.selectBtn.layer.borderColor = kMainText9Color.CGColor;
            x.selected = YES;
            x.backgroundColor = kMainColor;
        }
        
        self.selectBtn = x;
    }];
    
    return button;
}


- (void)getDetailData {
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:[NSString stringWithFormat:@"shop/detail/%@", self.shop_id] onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        self.dataDic = resultDic[@"data"];
        
        
        DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) shouldInfiniteLoop:YES imageGroups:self.dataDic[@"images"]];
        banner.autoScrollTimeInterval = 5;
        banner.autoScroll = NO;
        banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.bannerView addSubview:banner];
        [self.bannerView insertSubview:banner atIndex:0];
        
        self.shopTitle.text = self.dataDic[@"title"];

        NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
        NSData *data = [self.dataDic[@"description"] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
        CGRect rect = [attStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        self.showView.mj_h = rect.size.height+450;
        self.shopDes.attributedText = attStr;
        self.shopDes.textColor = kMainText9Color;
        
        self.shopPrice.text = [NSString stringWithFormat:@"$%@",self.dataDic[@"price"]];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
          NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"$%@",self.dataDic[@"line_price"]] attributes:attribtDic];
        self.oldPrice.attributedText = attribtStr;
        self.shopCount.text = [NSString stringWithFormat:@"%@ %@",AppLanguageStringWithKey(@"月销量"), self.dataDic[@"sold_count"]];
        self.shopTrans.text = [NSString stringWithFormat:@"%@：$%@",AppLanguageStringWithKey(@"运费"),self.dataDic[@"freight"]];
        
        [self.tableView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}


- (void)setTheme {
    
    [self.orderBtn setTitleColorPicker:IXColorPickerWithRGB(kTabBarUns,kWhiteR,kTabBarUns,kTabBarUns) forState:UIControlStateNormal];
    
    self.shopTitle.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shopCount.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,0x161E31,kLightGrayF5,kLightGrayF5);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,0x161E31,kLightGrayF5,kLightGrayF5);
}

@end
