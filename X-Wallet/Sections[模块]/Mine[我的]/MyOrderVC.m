//
//  MyOrderVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/26.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderListCell.h"

#import "WXMineOrderModel.h"

@interface MyOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *listArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (nonatomic, assign) NSInteger index;

@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"我的订单");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.btn1 setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kMainColorR,kBlackR,kBlackR) forState:UIControlStateSelected];
    [self.btn2 setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kMainColorR,kBlackR,kBlackR) forState:UIControlStateSelected];
    [self.btn3 setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kMainColorR,kBlackR,kBlackR) forState:UIControlStateSelected];
    [self.btn4 setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kMainColorR,kBlackR,kBlackR) forState:UIControlStateSelected];
    
    self.btn1.selected = YES;
    self.index = 0;
    @weakify(self);
    [[self.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.btn1.selected = YES;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
        self.btn4.selected = NO;
        self.line1.hidden = NO;
        self.line2.hidden = YES;
        self.line3.hidden = YES;
        self.line4.hidden = YES;
        if (self.index!=0) {
            self.index=0;
            [self p_requestList];
        }
    }];
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.btn1.selected = NO;
        self.btn2.selected = YES;
        self.btn3.selected = NO;
        self.btn4.selected = NO;
        self.line1.hidden = YES;
        self.line2.hidden = NO;
        self.line3.hidden = YES;
        self.line4.hidden = YES;
        if (self.index!=1) {
            self.index=1;
            [self p_requestList];
        }
    }];
    [[self.btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = YES;
        self.btn4.selected = NO;
        self.line1.hidden = YES;
        self.line2.hidden = YES;
        self.line3.hidden = NO;
        self.line4.hidden = YES;
        if (self.index!=2) {
            self.index=2;
            [self p_requestList];
        }
    }];
    [[self.btn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
        self.btn4.selected = YES;
        self.line1.hidden = YES;
        self.line2.hidden = YES;
        self.line3.hidden = YES;
        self.line4.hidden = NO;
        if (self.index!=3) {
            self.index=3;
            [self p_requestList];
        }
    }];
    
    [self p_requestList];
}

- (void)p_requestList {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    NSString *path = [NSString stringWithFormat:@"shop/orders/%zd",self.index];
    [NetWork dataTaskWithPath:path requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[WXMineOrderModel class] responsePath:@"data.data" completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.listArray = [NSMutableArray arrayWithArray:responseObject];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderListCell *cell = [MyOrderListCell initCell:tableView cellName:@"MyOrderListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
    
    [[[cell.borderBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"物流");
    }];
    
    [[[cell.fillBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"收货");
    }];
    WXMineOrderModel *model = self.listArray[indexPath.row];
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.product.image]];
    cell.showTitle.text = model.product.title;
    if (model.status==1) {
        if (self.index==0) {
            cell.showStatus.text = AppLanguageStringWithKey(@"已支付");
        }
        else {
            cell.showStatus.text = AppLanguageStringWithKey(@"待发货");
        }
        cell.fillBtn.hidden = NO;
        cell.borderBtn.hidden = YES;
        [cell.fillBtn setTitle:AppLanguageStringWithKey(@"未发货") forState:UIControlStateNormal];
    }
    else if (model.status==2) {
        cell.showStatus.text = AppLanguageStringWithKey(@"已发货");
        cell.fillBtn.hidden = NO;
        cell.borderBtn.hidden = YES ;
        [cell.fillBtn setTitle:AppLanguageStringWithKey(@"确认收货") forState:UIControlStateNormal];
    }
    else if (model.status==3) {
        cell.showStatus.text = AppLanguageStringWithKey(@"已收货");
        cell.fillBtn.hidden = YES;
        cell.borderBtn.hidden = NO;
        [cell.borderBtn setTitle:AppLanguageStringWithKey(@"已收货") forState:UIControlStateNormal];
    }
    cell.showPrice.text = [NSString stringWithFormat:@"%.2f",model.product.price];
    cell.showCount.text = [NSString stringWithFormat:@"x %zd",model.goods_number];
    
    cell.showInfo.text = [NSString stringWithFormat:AppLanguageStringWithKey(@"共%zd件商品 实付款：%@%@"),model.goods_number,model.total_amount,model.currency_name];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyOrderListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    
    
}


@end
