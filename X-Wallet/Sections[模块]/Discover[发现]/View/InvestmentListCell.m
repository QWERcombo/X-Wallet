//
//  InvestmentListCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InvestmentListCell.h"
#import "InvestmentListModel.h"

@implementation InvestmentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.investBtn.userInteractionEnabled = NO;
    
    self.showView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.totalLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.todayLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.statusLab.backgroundColorPicker = IXColorPickerWithRGB(0xF4F1FE,0x161E31,0xF4F1FE,0xF4F1FE);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    InvestmentListCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    InvestmentListModel *model = (InvestmentListModel *)dataObjc;
    
    cell.numLab.text = model.day;
    cell.titleLab.text = model.name;
    cell.statusLab.text = model.status_new.info;
    cell.totalLab.text = [NSString stringWithFormat:@"%.2f%%~%.2f%%",model.min_all.floatValue,model.max_all.floatValue];
    cell.todayLab.text = [NSString stringWithFormat:@"%.2f%%~%.2f%%",model.rate_min.floatValue,model.rate_max.floatValue];
    cell.hintLab.text = model.day.integerValue>=30?AppLanguageStringWithKey(@"总收益(月化)"):AppLanguageStringWithKey(@"总收益");
    if (model.is_vip.boolValue) {
        cell.vipImg.hidden = NO;
        cell.statusLab.backgroundColor = [[UIColor colorWithHexString:@"#FBA52B"] colorWithAlphaComponent:0.1];
        cell.statusLab.textColor = [UIColor colorWithHexString:@"#FBA52B"];
    } else {
        cell.vipImg.hidden = YES;
        cell.statusLab.backgroundColor = [kMainColor colorWithAlphaComponent:0.1];
        cell.statusLab.textColor = kMainColor;
    }
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 120;
}


@end
