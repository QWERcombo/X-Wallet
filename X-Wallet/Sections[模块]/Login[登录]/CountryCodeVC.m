//
//  CountryCodeVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CountryCodeVC.h"
#import "CountryCodeSearchView.h"
//model
#import "XWCountryModel.h"

@interface CountryCodeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** datasource */
@property (nonatomic, strong) NSArray *allListArray;
@property (nonatomic, strong) NSArray *listArray;
/** search */
@property (nonatomic, strong) CountryCodeSearchView *searchView;
@end

@implementation CountryCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.listArray = [NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"country_cell"];
    
    self.searchView = [[CountryCodeSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
    self.searchView.layer.cornerRadius = 17;
    @weakify(self);
    [[self.searchView.searchTF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"--%@",x);
        @strongify(self);
        self.listArray = [self.allListArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(XWCountryModel *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return ([[evaluatedObject.name uppercaseString] containsString:[x uppercaseString]]);
        }]];
        [self.tableView reloadData];
    }];
    self.navigationItem.titleView = self.searchView;
    
    [self p_requestList];
}

- (void)p_requestList {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"auth/area_code_list" requestMethod:NetWorkMethodPost version:1 parameters:nil mapModelClass:[XWCountryModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(NSArray * responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        self.allListArray = responseObject;
        self.listArray = [NSMutableArray arrayWithArray:responseObject];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"country_cell"];
    XWCountryModel *model = [self.listArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    cell.textLabel.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kTextBlack78,kTextBlack3,kTextBlack3);
    
    if (!self.isHideCode) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"+%@",model.tel];
        cell.detailTextLabel.textColorPicker = IXColorPickerWithRGB(kMainColorR,kWhiteR,kMainColorR,kMainColorR);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.valueBlock) {
        self.valueBlock([self.listArray objectAtIndex:indexPath.row]);
    }

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancel:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
