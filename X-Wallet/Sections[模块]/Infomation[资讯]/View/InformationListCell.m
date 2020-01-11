//
//  InformationListCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InformationListCell.h"
#import "InfomationListModel.h"

@implementation InformationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showImg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.showTitle.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label0.backgroundColorPicker = IXColorPickerWithRGB(0xF4F1FE,0x161E31,0xF4F1FE,0xF4F1FE);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    InformationListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    InfomationListModel *model = (InfomationListModel *)dataObjc;
    
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    cell.showTitle.text = model.title;
    cell.showTime.text = model.created_at;
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 80;
}



@end
