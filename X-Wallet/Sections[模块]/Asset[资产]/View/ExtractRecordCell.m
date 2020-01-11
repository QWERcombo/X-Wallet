//
//  ExtractRecordCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExtractRecordCell.h"

@implementation ExtractRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    ExtractRecordCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    //红#FA615C  绿#18D78B
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 70;
}

@end
