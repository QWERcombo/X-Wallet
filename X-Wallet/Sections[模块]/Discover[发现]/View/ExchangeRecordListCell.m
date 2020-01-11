//
//  ExchangeRecordListCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExchangeRecordListCell.h"

@implementation ExchangeRecordListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    ExchangeRecordListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 82;
}

@end
