//
//  ShopModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : BaseModel

@property (nonatomic, copy) NSString *is_tuijian;
@property (nonatomic, copy) NSString *shop_description;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *line_price;
@property (nonatomic, copy) NSString *shop_users;
@property (nonatomic, copy) NSArray<NSString*> *images;
@property (nonatomic, copy) NSString *sold_count;
@property (nonatomic, copy) NSString *admin_user_id;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *on_sale;
@property (nonatomic, copy) NSString *review_count;
@property (nonatomic, copy) NSString *freight;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *is_hot;
@property (nonatomic, copy) NSString *products_pid;
@property (nonatomic, copy) NSArray<NSString*> *buy_type;

@end

NS_ASSUME_NONNULL_END
