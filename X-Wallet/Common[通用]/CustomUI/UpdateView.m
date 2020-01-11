//
//  UpdateView.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UpdateView.h"

@implementation UpdateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"UpdateView" owner:self options:nil] firstObject];
        
        self.bgImgv.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"update_bg"],[UIImage imageNamed:@"update_bg"],[UIImage imageNamed:@"update_bg_2"]);
        self.titleLab.textColorPicker = IXColorPickerWithRGB(kWhiteR,kWhiteR,kBlackR);
        self.version.textColorPicker = IXColorPickerWithRGB(kWhiteR,kWhiteR,kBlackR);
        self.checkBtn.backgroundColorPicker = IXColorPickerWithRGB(kMainColorR,kMainColorR,0xC61220);
        self.titleLab.text = AppLanguageStringWithKey(@"发现新版本");
        
        self.scrollView = [UIScrollView new];
        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Christmas"]) {
                make.left.equalTo(self.contentView.mas_left).offset(50);
                make.right.equalTo(self.contentView.mas_right).offset(-50);
                self.titleToLeftConst.constant = 56;
                self.titleToTopConst.constant = 35;
            } else {
                make.left.equalTo(self.contentView.mas_left).offset(25);
                make.right.equalTo(self.contentView.mas_right).offset(-25);
                self.titleToLeftConst.constant = 33;
                self.titleToTopConst.constant = 28;
            }
            make.top.equalTo(self.contentView.mas_top).offset(120);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-100);
        }];
        
        self.containerView = [UIView new];
        [self.scrollView addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.mas_equalTo(self.scrollView.mas_width);
        }];
        
        self.contentLab = [UILabel new];
//        self.contentLab.backgroundColor = [UIColor purpleColor];
        self.contentLab.numberOfLines = 0;
        self.contentLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.containerView addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.containerView);
        }];
        
        @weakify(self);
        [[self.checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.updateBlock) {
//                [self removeFromSuperview];
                self.updateBlock();
            }
        }];
        
        self.frame = frame;
    }
    return self;
}


+ (void)showUpdateViewWithVersion:(NSString *)version content:(NSString *)content block:(UpdateBlock)block {
    
    UpdateView *view = [[UpdateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.version.text = version;
    view.contentLab.text = content;
    view.updateBlock = block;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

@end
