//
//  InfomationListModel.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfomationListModel : BaseModel

@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *created_at;

@end

NS_ASSUME_NONNULL_END
