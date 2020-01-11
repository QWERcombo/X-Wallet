
//
//  CancelContractView.m
//  X-Wallet
//
//  Created by 赵越 on 2019/12/1.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CancelContractView.h"

@implementation CancelContractView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"CancelContractView" owner:self options:nil] firstObject];
        
        self.bgImgv.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"cancel_bg"],[UIImage imageNamed:@"cancel_bg"],[UIImage imageNamed:@"cancel_bg_2"],[UIImage imageNamed:@"cancel_bg_3"]);
        [self.doneBtn setTitleColorPicker:IXColorPickerWithRGB(kMainColorR,kMainColorR,0xFC4C4C,0xFC4C4C) forState:UIControlStateNormal];
        
        self.frame = frame;
    }
    return self;
}


- (IBAction)cancel:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)done:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock(YES);
        [self removeFromSuperview];
    }
}


+ (void)showCancelContractView:(NSString *)titleStr feeStr:(NSString *)feeStr block:(CancelContractBlock)block {
    
    CancelContractView *cancelView = [[CancelContractView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cancelView.cancelBlock = block;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF2F2F"]} range:[titleStr rangeOfString:feeStr]];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF2F2F"]} range:[titleStr rangeOfString:@"1%"]];
    cancelView.descLab.attributedText = attStr;
    
    [[UIApplication sharedApplication].keyWindow addSubview:cancelView];
}

@end
