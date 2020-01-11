//
//  CountryCodeSearchView.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CountryCodeSearchView.h"

@implementation CountryCodeSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"CountryCodeSearchView" owner:self options:nil] firstObject];
        
        self.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
        self.searchTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        
        self.frame = frame;
    }
    return self;
}


- (CGSize)intrinsicContentSize {

    return UILayoutFittingExpandedSize;
}


@end
