//
//  RuleView.h
//  X-Wallet
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuleView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *ruleBgImg;

@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIScrollView *scrollView;

+ (void)showRuleViewWithTitle:(NSString *)titleText content:(NSString *)contentText;
@end

NS_ASSUME_NONNULL_END
