//
//  ExchangeRecordVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExchangeRecordVC.h"
#import "ExchangeRecordListCell.h"

@interface ExchangeRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation ExchangeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"兑换记录");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    for (int i=0; i<5; i++) {
        [self.listArray addObject:@""];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExchangeRecordListCell *cell = [ExchangeRecordListCell initCell:tableView cellName:@"ExchangeRecordListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ExchangeRecordListCell tableViewHeight];
}



@end
