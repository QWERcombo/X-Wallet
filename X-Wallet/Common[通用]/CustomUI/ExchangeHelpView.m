//
//  ExchangeHelpView.m
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExchangeHelpView.h"

@implementation ExchangeHelpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ExchangeHelpView" owner:self options:nil] firstObject];
        
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        @weakify(self);
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            [self removeFromSuperview];
        }];
        [self addGestureRecognizer:tap];
        
        self.frame = frame;
    }
    return self;
}



+ (void)showHelpViewWithContent:(NSString *)content {
    
    ExchangeHelpView *help = [[ExchangeHelpView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    help.contentLab.text = content;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:help];
}

@end
