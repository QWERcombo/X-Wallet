//
//  CommunityListCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CommunityListCell.h"

@implementation CommunityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    CommunityListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
 
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 62;
}


@end
