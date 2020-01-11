//
//  DiscoverSectionView.m
//  X-Wallet
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DiscoverSectionView.h"

@implementation DiscoverSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    self.iconImg.imagePicker = IXImagePickerWithImages([UIImage new],[UIImage new],[UIImage imageNamed:@"con_0"],[UIImage imageNamed:@"con_0"]);
}

@end
