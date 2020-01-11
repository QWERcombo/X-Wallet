//
//  BannerCell.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BannerCell.h"
//#import "DCCycleScrollView.h"

@implementation BannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
        @weakify(self);
        [self.rac_prepareForReuseSignal subscribeNext:^(RACUnit * _Nullable x) {
            @strongify(self);
            [self.banner removeFromSuperview];
        }];
        
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    
    self.banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) shouldInfiniteLoop:YES imageGroups:imageArr];
    self.banner.autoScrollTimeInterval = 5;
    self.banner.autoScroll = YES;
    self.banner.isZoom = YES;
    self.banner.itemSpace = -15;
    self.banner.imgCornerRadius = 10;
    self.banner.itemWidth = self.frame.size.width - 40;
    self.banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    //隐藏pageControl
    self.banner.pageControl.hidden = YES;
    self.banner.delegate = self;
    [self addSubview:self.banner];
}

- (void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"hahaha");
    
    
}

@end
