//
//  AssetListCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetListCell.h"

@implementation AssetListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showView.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.showName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.showPrice.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    AssetListCell *cell = [super initCell:tableView cellName:@"AssetListCell" dataObjc:dataObjc];
    
    
    
    return cell;
}

+ (CGFloat)tableViewHeight {
    return 80;
}

@end
