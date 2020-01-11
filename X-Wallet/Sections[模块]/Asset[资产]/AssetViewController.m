//
//  AssetViewController.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/20.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetListVC.h"
#import "AssetKeyVC.h"
#import "UpdateView.h"
//models
#import "XWHomeModel.h"
#import "XWHomeAlertView.h"

@interface AssetViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) AssetListVC *listVC;
@property (nonatomic, strong) AssetKeyVC *keyVC;

@property (nonatomic, strong) XWHomeModel *model;

@end

@implementation AssetViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self p_showUpdateView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftView.layer.cornerRadius = 2;
    self.rightView.layer.cornerRadius = 2;
    self.navigationController.navigationBarHidden = YES;
    self.buyBtn.hidden = YES;
    [self.leftBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateSelected];
    [self.rightBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateSelected];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50+STATUS_HEIGHT);
    }];
    
    
    UIView *containerView = [UIView new];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    self.listVC = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"AssetListVC"];
    [self addChildViewController:self.listVC];
    [self.listVC didMoveToParentViewController:self];
    [containerView addSubview:self.listVC.view];
    [self.listVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(containerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];

    self.keyVC = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"AssetKeyVC"];
    [self addChildViewController:self.keyVC];
    [self.keyVC didMoveToParentViewController:self];
    [containerView addSubview:self.keyVC.view];
    [self.keyVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(containerView);
        make.left.equalTo(self.listVC.view.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];

    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.keyVC.view.mas_right);
    }];
    
    
    [self operate];
    
    [self p_requestHomeInfo];
}

- (void)p_requestHomeInfo {
    [SVProgressHUD showInfoWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"wallet/wallets_list" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[XWHomeModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.model = responseObject;
            self.listVC.model = responseObject;
        }
    }];
    
    [NetWork dataTaskWithPath:@"home" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:nil responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        if (responseObject) {
            NSInteger isShow = [responseObject[@"info"][@"is_show"] integerValue];
            if (isShow) {
                [self p_showHomeAlert];
            }
        }
    }];
}

- (void)p_showHomeAlert {
    [NetWork dataTaskWithPath:@"contract/receiveIncome" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[XWHomeAlertModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(XWHomeAlertModel *responseObject, NSError * _Nonnull error) {
        if (!error) {
            XWHomeAlertView *alertView = [[XWHomeAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            alertView.model = responseObject;
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];

        }
    }];
}

- (void)operate {
    
    @weakify(self);
    self.leftBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        
        return [RACSignal empty];
    }];
    self.rightBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        
        return [RACSignal empty];
    }];
    
    /** 滑动 */
    [[self rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        UIScrollView *scrollView = [x first];
        @strongify(self);
        if (scrollView.contentOffset.x/SCREEN_WIDTH == 1) {
            self.buyBtn.hidden = NO;
            [self.rightBtn.rac_command execute:nil];
        } else {
            self.buyBtn.hidden = YES;
            [self.leftBtn.rac_command execute:nil];
        }
    }];
    
    /** 购买 */
    self.buyBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIButton*  _Nullable input) {
        
        return [RACSignal empty];
    }];
    
}



@end
