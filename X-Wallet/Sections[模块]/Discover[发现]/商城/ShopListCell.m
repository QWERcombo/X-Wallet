//
//  ShopListCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopListCell.h"
#import "ShopModel.h"

@implementation ShopListCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self=[super initWithFrame:frame]) {
        self.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
        self.layer.cornerRadius = 6;
        
        self.shop_img = [[UIImageView alloc] init];
        self.shop_img.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.shop_img];
        [self.shop_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.mas_equalTo(128);
        }];
        
        
        self.shop_name = [[UILabel alloc] init];
        self.shop_name.text = @"-";
        self.shop_name.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        self.shop_name.font = [UIFont systemFontOfSize:12];
        self.shop_name.numberOfLines = 2;
        [self.contentView addSubview:self.shop_name];
        [self.shop_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(9);
            make.top.equalTo(self.shop_img.mas_bottom).offset(10);
            make.width.mas_equalTo((SCREEN_WIDTH-40)/2-18);
        }];
        
        self.shop_price = [[UILabel alloc] init];
        self.shop_price.text = @"59";
        self.shop_price.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        self.shop_price.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [self.contentView addSubview:self.shop_price];
        [self.shop_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(9);
            make.top.equalTo(self.shop_name.mas_bottom).offset(10);
        }];

        self.shop_count = [[UILabel alloc] init];
        self.shop_count.text = @"1022人付款";
        self.shop_count.font = [UIFont systemFontOfSize:12];
        self.shop_count.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:self.shop_count];
        [self.shop_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-9);
            make.centerY.equalTo(self.shop_price.mas_centerY);
        }];
    }
    
    return self;
}

- (void)setDataObjc:(ShopModel *)model {
    
    [self.shop_img sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.shop_name.text = model.title;
    self.shop_price.text = [NSString stringWithFormat:@"$%@", model.price];
    self.shop_count.text = [NSString stringWithFormat:@"%@%@", model.sold_count,AppLanguageStringWithKey(@"人付款")];
}
@end
