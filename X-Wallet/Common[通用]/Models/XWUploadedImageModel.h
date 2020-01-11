//
//  XWUploadedImageModel.h
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWUploadedImageModel : BaseModel

@property (nonatomic, strong) NSString *show_path;

@property (nonatomic, strong) NSString *path;

@end

NS_ASSUME_NONNULL_END
