//
//  DiscoverSectionCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DiscoverSectionCell.h"

@implementation DiscoverSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.secName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.contentView.backgroundColorPicker = IXColorPickerWithRGB(0xEEF2FE,kMineShowN,0xEEF2FE,0xEEF2FE);
    self.iconImg.imagePicker = IXImagePickerWithImages([UIImage new],[UIImage new],[UIImage imageNamed:@"con_1"],[UIImage imageNamed:@"con_1"]);
}

@end
