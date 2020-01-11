//
//  SetPsdVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "SetPsdVC.h"
#import "CheckCodeVC.h"

@interface SetPsdVC ()

@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UITextField *againTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *topLab;

@end

@implementation SetPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.layer.cornerRadius = 6;
    self.nextBtn.enabled = NO;
    self.nextBtn.alpha = 0.5;
    [self.confirmBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    self.topLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.psdTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.psdTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.againTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.againTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.inviteTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.inviteTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
    
    [self operate];
}

- (void)operate {
    
    @weakify(self);
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.confirmBtn.selected = !self.confirmBtn.selected;
    }];
    
    
    RAC(self.nextBtn, enabled) = [RACSignal combineLatest:@[self.psdTF.rac_textSignal,self.againTF.rac_textSignal,self.inviteTF.rac_textSignal,RACObserve(self.confirmBtn, selected)] reduce:^id _Nonnull(NSString *psd, NSString *again, NSString *invite, NSString *isSelect){
        @strongify(self);
        if (psd.length && again.length && invite.length &&[psd isEqualToString:again] && [isSelect boolValue]) {
            self.nextBtn.alpha = 1;
        } else {
            self.nextBtn.alpha = 0.5;
        }

        return @(psd.length && again.length && invite.length &&[psd isEqualToString:again] && [isSelect boolValue]);
    }];
    
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        CheckCodeVC *code = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CheckCodeVC"];
        code.type = CodeType_Pay;
        code.accountStr = self.accountStr;
        code.codeStr = self.codeStr;
        code.passwordStr = self.psdTF.text;
        code.area_code = self.area_code;
        code.inviteStr = self.inviteTF.text;
        [self.navigationController pushViewController:code animated:YES];
    }];
    
}



@end
