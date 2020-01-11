//
//  UpdateView.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UpdateBlock)(void);

@interface UpdateView : UIView

@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToLeftConst;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToTopConst;
@property (weak, nonatomic) IBOutlet UIView *lineView;

/** scroll */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, copy) UpdateBlock updateBlock;

+ (void)showUpdateViewWithVersion:(NSString *)version content:(NSString *)content block:(UpdateBlock)block;
@end

NS_ASSUME_NONNULL_END
