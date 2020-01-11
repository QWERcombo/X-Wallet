//
//  ShopListCell.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopModel;
@interface ShopListCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *shop_img;
@property (strong, nonatomic) UILabel *shop_name;
@property (strong, nonatomic) UILabel *shop_price;
@property (strong, nonatomic) UILabel *shop_count;

- (void)setDataObjc:(ShopModel *)model;
@end

NS_ASSUME_NONNULL_END
