//
//  AssetListVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetListVC.h"
#import "AssetListCell.h"
#import "AssetDetailVC.h"
//models
#import "XWHomeModel.h"

@interface AssetListVC ()<UITableViewDelegate,UITableViewDataSource>
/** array */
@property (weak, nonatomic) IBOutlet UILabel *assetLabel;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topImg;

@end

@implementation AssetListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.topImg.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"ass_top_bg"],[UIImage imageNamed:@"ass_top_bg"],[UIImage imageNamed:@"ass_top_bg"],[UIImage imageNamed:@"ass_top_bg_1"]);
    
    @weakify(self);
    [[self.hideBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            self.assetLabel.text = [NSString stringWithFormat:@"$%@",self.model.doll];
        } else {
            self.assetLabel.text = @"******";
        }
    }];
    
    
}

- (void)setModel:(XWHomeModel *)model {
    _model = model;
    self.assetLabel.text = [NSString stringWithFormat:@"$%@",self.model.doll];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWHomeAssetModel *model = _model.list[indexPath.row];
    AssetListCell *cell = [AssetListCell initCell:tableView cellName:@"AssetListCell" dataObjc:model];
    cell.showName.text = model.currency_name;
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.showPrice.text = [NSString stringWithFormat:@"%@",model.change_balance];
    cell.showDoular.text = [NSString stringWithFormat:@"≈$%@",model.doll_balance];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AssetListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AssetDetailVC *detail = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"AssetDetailVC"];
    XWHomeAssetModel *model = _model.list[indexPath.row];
    detail.title = model.currency_name;
    detail.id = model.currency_id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
