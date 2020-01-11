//
//  DDBaseTableViewCell.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc
{
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellName owner:nil options:nil] firstObject];
    }
    cell.contentView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,0x0E1824,kWhiteR,kWhiteR);
    return cell;    
}

+ (CGFloat)tableViewHeight
{
    return 44.f;
}

@end
