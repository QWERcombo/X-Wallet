//
//  CommunityRecordListCell.m
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CommunityRecordListCell.h"
#import "CommunityRecordModel.h"

@implementation CommunityRecordListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.desLab.textColorPicker = IXColorPickerWithRGB(kMainColorR,kWhiteR,kMainColorR,kMainColorR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    CommunityRecordListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    CommunityRecordModel *model = (CommunityRecordModel *)dataObjc;
    
    cell.titleLab.text = model.memo_new.info;
    cell.timeLab.text = model.created_at;
    cell.desLab.text = [NSString stringWithFormat:@"%@XCN = $%@",model.value,model.number];
    
    return cell;
}


@end
