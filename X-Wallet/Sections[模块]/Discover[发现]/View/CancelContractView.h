//
//  CancelContractView.h
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelContractBlock)(BOOL isDone);

@interface CancelContractView : UIView

@property (nonatomic, copy) CancelContractBlock cancelBlock;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgv;



+ (void)showCancelContractView:(NSString *)titleStr feeStr:(NSString *)feeStr block:(CancelContractBlock)block;

@end

NS_ASSUME_NONNULL_END
