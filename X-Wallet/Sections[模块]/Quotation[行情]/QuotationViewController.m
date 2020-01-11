//
//  QuotationViewController.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/20.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "QuotationViewController.h"
#import "QuotationListCell.h"
#import "QuotationBLL.h"
#import "QuotationModel.h"

@interface QuotationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *topLeft;
@property (weak, nonatomic) IBOutlet UILabel *topCenter;
@property (weak, nonatomic) IBOutlet UILabel *topRight;
@property (weak, nonatomic) IBOutlet UILabel *midLeft;
@property (weak, nonatomic) IBOutlet UILabel *midLeft1;
@property (weak, nonatomic) IBOutlet UILabel *midRight;
@property (weak, nonatomic) IBOutlet UILabel *midRight1;
@property (weak, nonatomic) IBOutlet UIImageView *botLeftImg;
@property (weak, nonatomic) IBOutlet UIButton *botLeftUp;
@property (weak, nonatomic) IBOutlet UIButton *botLeftDow;
@property (weak, nonatomic) IBOutlet UIImageView *botMidImg;
@property (weak, nonatomic) IBOutlet UIButton *botMidUp;
@property (weak, nonatomic) IBOutlet UIButton *botMidDow;
@property (weak, nonatomic) IBOutlet UIImageView *botRightImg;
@property (weak, nonatomic) IBOutlet UIButton *botRightUp;
@property (weak, nonatomic) IBOutlet UIButton *botRightDow;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *leftInfo;
@property (weak, nonatomic) IBOutlet UILabel *midInfo;
@property (weak, nonatomic) IBOutlet UILabel *rightInfo;
@property (weak, nonatomic) IBOutlet UIView *scnView;
@property (weak, nonatomic) IBOutlet UILabel *xcnLab;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIImageView *topBgImgv;


@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,assign) BOOL isXcn;
@property (nonatomic,strong) NSSortDescriptor *nameDestor;//平台
@property (nonatomic,strong) NSSortDescriptor *usdtDestor;//最新价
@property (nonatomic,strong) NSSortDescriptor *upanddownDestor;//涨跌
@end

@implementation QuotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.listArray = [NSMutableArray array];
    
    self.topCenter.layer.cornerRadius = 12;
    self.topCenter.layer.masksToBounds = YES;
    
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getQuoData];
    }];
    
    [self getQuoData];
    [self operate];
}

- (void)initScrollView {
    
    [self.scrollView removeFromSuperview];
    self.scrollView = [UIScrollView new];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.tableView.mas_top).offset(-30);
    }];
    UIView *containerView = [UIView new];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIButton *lastBtn = nil;
    for (int i=0; i<self.listArray.count; i++) {
        
        QuotationModel *model = [self.listArray objectAtIndex:i];
        UIButton *button = [self getItemButtonWithTitle:model.name];
        button.tag = 100+i;
        [containerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(10);
            } else {
                make.left.equalTo(containerView.mas_left);
            }
            make.centerY.equalTo(containerView.mas_centerY);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(30);
        }];
        
        if (i==0) {
            button.backgroundColor = [UIColor jyl_WhiteColor];
            [button setTitleColor:kMainColor forState:UIControlStateNormal];
            self.selectBtn = button;
            if ([model.name isEqualToString:@"XCN"]) {
                self.isXcn = YES;
            } else {
                self.isXcn = NO;
            }
            [self changeInfo];
        }
        lastBtn = button;
    }
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastBtn.mas_right);
    }];
    
    self.topView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    self.scnView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    self.topLeft.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.topRight.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.midLeft.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.midRight.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.topBgImgv.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"quo_top_bg"],[UIImage imageNamed:@"quo_top_bg"],[UIImage imageNamed:@"quo_top_bg_2"],[UIImage imageNamed:@"quo_top_bg_3"]);
}

- (UIButton *)getItemButtonWithTitle:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 15;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        
        if (self.selectBtn != x) {
            self.selectBtn.backgroundColor = [UIColor clearColor];
            [self.selectBtn setTitleColor:UIColor.jyl_WhiteColor forState:UIControlStateNormal];
            x.backgroundColor = [UIColor jyl_WhiteColor];
            [x setTitleColor:kMainColor forState:UIControlStateNormal];
            self.selectBtn = x;
        }
        if ([x.currentTitle isEqualToString:@"XCN"]) {
            self.isXcn = YES;
        } else {
            self.isXcn = NO;
        }
        [self changeInfo];
    }];
    
    return button;
}

- (void)changeInfo {
    
    if (self.isXcn) {
        self.scnView.hidden = NO;
        self.infoView.hidden = YES;
        self.xcnLab.text = @"USDT";
//        self.leftInfo.text = @"名称";
//        self.midInfo.text = @"价格";
//        self.rightInfo.text = @"24h";
        self.topView.mj_h = 90;
    } else {
        self.scnView.hidden = YES;
        self.infoView.hidden = NO;
//        self.leftInfo.text = @"平台";
//        self.midInfo.text = @"最新价";
//        self.rightInfo.text = @"涨跌幅";
        self.topView.mj_h = 170;
        
        QuotationModel *model = [self.listArray objectAtIndex:self.selectBtn.tag-100];
        self.topRight.text = [NSString stringWithFormat:@"$%@", model.info.diff];
        self.midLeft.text = model.info.max_platform;
        self.midLeft1.text = [NSString stringWithFormat:@"$%@",model.info.max_price];
        self.midRight.text = model.info.min_platform;
        self.midRight1.text = [NSString stringWithFormat:@"$%@",model.info.min_price];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArray.count) {
        QuotationModel *model = [self.listArray objectAtIndex:self.selectBtn.tag-100];
        
        return model.list.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotationModel *model = [self.listArray objectAtIndex:self.selectBtn.tag-100];
    
    return [QuotationListCell initCell:tableView cellName:@"QuotationListCell" dataObjc:[model.list objectAtIndex:indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [QuotationListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
    
}


- (void)operate {
    //upanddown
    @weakify(self);
    [[self.botLeftUp rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botLeftImg.image = [UIImage imageNamed:@"quo_up"];
        NSLog(@"左上");
        self.nameDestor = [NSSortDescriptor sortDescriptorWithKey:@"platform"ascending:YES];
        [self refreshListByDescriptors:self.nameDestor];
    }];
    [[self.botLeftDow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botLeftImg.image = [UIImage imageNamed:@"quo_down"];
        NSLog(@"左下");
        self.nameDestor = [NSSortDescriptor sortDescriptorWithKey:@"platform"ascending:NO];
        [self refreshListByDescriptors:self.nameDestor];
    }];
    [[self.botMidUp rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botMidImg.image = [UIImage imageNamed:@"quo_up"];
        NSLog(@"中上");
        self.usdtDestor = [NSSortDescriptor sortDescriptorWithKey:@"usdt_price"ascending:YES];
        [self refreshListByDescriptors:self.usdtDestor];
    }];
    [[self.botMidDow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botMidImg.image = [UIImage imageNamed:@"quo_down"];
        NSLog(@"中下");
        self.usdtDestor = [NSSortDescriptor sortDescriptorWithKey:@"usdt_price"ascending:NO];
        [self refreshListByDescriptors:self.usdtDestor];
    }];
    [[self.botRightUp rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botRightImg.image = [UIImage imageNamed:@"quo_up"];
        self.upanddownDestor = [NSSortDescriptor sortDescriptorWithKey:@"upanddown"ascending:YES];
        [self refreshListByDescriptors:self.upanddownDestor];
        NSLog(@"右上");
    }];
    [[self.botRightDow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.botRightImg.image = [UIImage imageNamed:@"quo_down"];
        self.upanddownDestor = [NSSortDescriptor sortDescriptorWithKey:@"upanddown"ascending:NO];
        [self refreshListByDescriptors:self.upanddownDestor];
        NSLog(@"右下");
    }];
    
}

- (void)refreshListByDescriptors:(NSSortDescriptor *)descriptor {
    
    for (QuotationModel *model in self.listArray) {

        model.list = [model.list sortedArrayUsingDescriptors:@[descriptor]];
//        NSLog(@"%@", model.list);
    }
    
    [self.tableView reloadData];
}

#pragma mark - RequestData
- (void)getQuoData {
    
    [self loading];
    [[QuotationBLL sharedQuotationBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"wallet/hangqing_new" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        [self.tableView.mj_header endRefreshing];
        [self.listArray removeAllObjects];
        
        NSArray *array = resultDic[@"data"];
        for (NSDictionary *dic in array) {
            QuotationModel *model = [[QuotationModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        
        self.botRightImg.image = [UIImage imageNamed:@"quo_nor"];
        self.botMidImg.image = [UIImage imageNamed:@"quo_nor"];
        self.botLeftImg.image = [UIImage imageNamed:@"quo_nor"];
        [self initScrollView];
        [self.tableView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
        [self.tableView.mj_header endRefreshing];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

@end
