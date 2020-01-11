//
//  ExtractAlertView.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExtractAlertView.h"

@implementation ExtractAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ExtractAlertView" owner:self options:nil] firstObject];
        
        @weakify(self);
        [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self removeFromSuperview];
        }];        
        self.frame = frame;
    }
    return self;
}

+ (ExtractAlertView *)showExtractAlertViewWithInfo:(NSString *)infoStr address:(NSString *)addressStr time:(NSString *)timeStr status:(NSString *)statusStr {
    
    ExtractAlertView *alert = [[ExtractAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alert.showInfo.text = infoStr;
    alert.address.text = addressStr;
    alert.time.text = timeStr;
    alert.status.text = statusStr;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    return alert;
}


@end
