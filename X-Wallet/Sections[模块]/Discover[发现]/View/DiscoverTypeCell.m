//
//  DiscoverTypeCell.m
//  X-Wallet
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DiscoverTypeCell.h"

@implementation DiscoverTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.typeName = [UILabel new];
    self.typeName.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.typeName];
    self.typeName.textAlignment = NSTextAlignmentCenter;
    [self.typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeImg.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo((SCREEN_WIDTH-30-40)/5);
    }];
    
    self.typeName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    self = [[NSBundle mainBundle]loadNibNamed:@"DiscoverTypeCell" owner:self options:nil].lastObject;
    }
    
    return self;
}



@end
