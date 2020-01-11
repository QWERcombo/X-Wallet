//
//  AssetDetailCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetDetailCell.h"

@implementation AssetDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showTitle.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    AssetDetailCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 74;
}

@end
