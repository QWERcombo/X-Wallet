//
//  ShopChooseSizeView.h
//  X-Wallet
//
//  Created by 赵越 on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SizeBlock)(NSString *size, NSInteger number);

@interface ShopChooseSizeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showName;
@property (weak, nonatomic) IBOutlet UILabel *showPrice;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *showSize;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, copy) SizeBlock sizeBlock;

+ (void)showShopSizeView:(NSDictionary *)dataDic sizeBlock:(SizeBlock)sizeBlock;
@end

NS_ASSUME_NONNULL_END
