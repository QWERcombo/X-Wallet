
//
//  RuleView.m
//  X-Wallet
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "RuleView.h"

@implementation RuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"RuleView" owner:self options:nil] firstObject];
        
        self.scrollView = [UIScrollView new];
        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(40);
            make.right.equalTo(self.contentView.mas_right).offset(-40);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
            make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        }];
        
        UIView *containerView = [UIView new];
        [self.scrollView addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
        }];
        
        self.contentLab = [UILabel new];
        self.contentLab.numberOfLines = 0;
        self.contentLab.font = [UIFont systemFontOfSize:14];
        self.contentLab.textColor = kMainText9Color;
        [containerView addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(containerView.mas_left).offset(10);
            make.right.equalTo(containerView.mas_right).offset(-10);
            make.top.equalTo(containerView.mas_top).offset(10);
            make.bottom.equalTo(containerView.mas_bottom).offset(-10);
        }];
        
        self.ruleBgImg.imagePicker = IXImagePickerWithImages([UIImage new],[UIImage new],[UIImage imageNamed:@"rule_bg"],[UIImage imageNamed:@"rule_bg_1"]);
        
        self.frame = frame;
    }
    return self;
}


+ (void)showRuleViewWithTitle:(NSString *)titleText content:(NSString *)contentText {
    
    RuleView *rule = [[RuleView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    rule.titleLab.text = titleText;
    rule.contentLab.text = contentText;
    [[UIApplication sharedApplication].keyWindow addSubview:rule];
}

- (IBAction)close:(UIButton *)sender {
    [self removeFromSuperview];
}


@end
