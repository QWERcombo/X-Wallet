//
//  ShopTypeCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopTypeCell.h"

@implementation ShopTypeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self=[super initWithFrame:frame]) {
        self.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
        self.layer.cornerRadius = 10;
        
        self.shop_img = [[UIImageView alloc] init];
        [self.contentView addSubview:self.shop_img];
        [self.shop_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15);
        }];
        
        
        self.shop_name = [[UILabel alloc] init];
        self.shop_name.font = [UIFont systemFontOfSize:14];
        self.shop_name.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        [self.contentView addSubview:self.shop_name];
        [self.shop_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shop_img.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];

        self.shop_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shop_btn setTitle:AppLanguageStringWithKey(@"点击进入") forState:UIControlStateNormal];
        self.shop_btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        self.shop_btn.backgroundColor = kMainColor;
        self.shop_btn.layer.cornerRadius = 15;
        self.shop_btn.layer.masksToBounds = YES;
        [self.contentView addSubview:self.shop_btn];
        [self.shop_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(74);
            make.height.mas_equalTo(30);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];

        
    }
    
    return self;
}



@end
