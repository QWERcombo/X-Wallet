//
//  InviteVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/26.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InviteVC.h"
#import "UIImage+Extension.h"

@interface InviteVC ()
@property (weak, nonatomic) IBOutlet UILabel *inviteCode;
@property (weak, nonatomic) IBOutlet UIButton *acopyCode;
@property (weak, nonatomic) IBOutlet UIImageView *qrImg;
@property (weak, nonatomic) IBOutlet UILabel *linkLab;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *acopyLink;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

@implementation InviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
    self.title = AppLanguageStringWithKey(@"邀请好友");
    self.inviteCode.text = [NSString stringWithFormat:@"%@",self.invitation_code];
    self.userLabel.text = [NSString stringWithFormat:@"+%@ %@ share",self.area_code,self.hidden_phone];
    self.linkLab.text = self.invite_url;
    
    CIImage *ciimg = [UIImage creatCodeImageString:self.linkLab.text];
    UIImage *img = [UIImage creatNonInterpolatedUIImageFormCIImage:ciimg withSize:140];
    self.qrImg.image = img;
    
    [[self.acopyCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        paste.string = self.inviteCode.text;
        [self promptReqSuccess:AppLanguageStringWithKey(@"复制邀请码成功")];
    }];
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIImageWriteToSavedPhotosAlbum(self.qrImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    [[self.acopyLink rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        paste.string = self.linkLab.text;
        [self promptReqSuccess:AppLanguageStringWithKey(@"复制链接码成功")];
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = AppLanguageStringWithKey(@"保存图片失败");
        [self promptMsg:msg];
    }else{
        msg = AppLanguageStringWithKey(@"保存图片成功");
        [self promptReqSuccess:msg];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
