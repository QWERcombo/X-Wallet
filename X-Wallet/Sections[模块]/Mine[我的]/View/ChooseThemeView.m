//
//  ChooseThemeView.m
//  X-Wallet
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ChooseThemeView.h"

@implementation ChooseThemeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ChooseThemeView" owner:self options:nil] firstObject];
        
        @weakify(self);
        [[self.dayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.dayBtn.selected = YES;
            self.nightBtn.selected = NO;
            self.christmasBtn.selected = NO;
            self.nnewYearBtn.selected = NO;
        }];
        [[self.nightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.dayBtn.selected = NO;
            self.nightBtn.selected = YES;
            self.christmasBtn.selected = NO;
            self.nnewYearBtn.selected = NO;
        }];
        [[self.christmasBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.dayBtn.selected = NO;
            self.nightBtn.selected = NO;
            self.christmasBtn.selected = YES;
            self.nnewYearBtn.selected = NO;
        }];
        [[self.nnewYearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.dayBtn.selected = NO;
            self.nightBtn.selected = NO;
            self.christmasBtn.selected = NO;
            self.nnewYearBtn.selected = YES;
        }];
        
        
        self.frame = frame;
    }
    return self;
}

- (IBAction)cancel:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)done:(UIButton *)sender {
    
    if (self.dayBtn.selected && !self.nightBtn.selected && !self.christmasBtn.selected && !self.nnewYearBtn.selected) {
        [[IXColorMgr defaultMgr] changeColorVersionWithIndex:0];
        UserData.share.showMode = @"Day";
    } else if (!self.dayBtn.selected && self.nightBtn.selected && !self.christmasBtn.selected && !self.nnewYearBtn.selected) {
        [[IXColorMgr defaultMgr] changeColorVersionWithIndex:1];
        UserData.share.showMode = @"Night";
    } else if (!self.dayBtn.selected && !self.nightBtn.selected && self.christmasBtn.selected && !self.nnewYearBtn.selected) {
        [[IXColorMgr defaultMgr] changeColorVersionWithIndex:2];
        UserData.share.showMode = @"Christmas";
        
    } else if (!self.dayBtn.selected && !self.nightBtn.selected && !self.christmasBtn.selected && self.nnewYearBtn.selected) {
        [[IXColorMgr defaultMgr] changeColorVersionWithIndex:3];
        UserData.share.showMode = @"NewYear";
        
    }
    
    if (self.doneBlock) {
        self.doneBlock();
        [self removeFromSuperview];
    }
}

+ (void)showThemeViewWithBlock:(void(^)(void))complete {
    
    ChooseThemeView *theme = [[ChooseThemeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    theme.doneBlock = complete;
    if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Day"]) {
        [theme.dayBtn setSelected:YES];
    } else if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Night"]) {
        [theme.nightBtn setSelected:YES];
    } else if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Christmas"]) {
        [theme.christmasBtn setSelected:YES];
    } else if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"NewYear"]) {
        [theme.nnewYearBtn setSelected:YES];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:theme];
}

@end
