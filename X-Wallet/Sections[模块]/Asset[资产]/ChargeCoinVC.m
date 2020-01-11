//
//  ChargeCoinVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ChargeCoinVC.h"
#import "UIImage+Extension.h"
//models
#import "XWHomeAssetModel.h"
#import "YBPopupMenu.h"

@interface ChargeCoinVC ()<YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UIImageView *coinImage;
@property (weak, nonatomic) IBOutlet UIButton *selectCoinBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImg;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UIButton *acopyBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *selectCoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIView *view0;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *listArray;

@end

@implementation ChargeCoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"充币");
    self.tableView.tableFooterView = [UIView new];
    self.acopyBtn.layer.cornerRadius = 6;
    self.index = 0;
    
    
    @weakify(self);
    
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    self.selectCoinLabel.userInteractionEnabled = YES;
    [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        NSMutableArray *array = @[].mutableCopy;
        for (XWHomeAssetModel *model in self.listArray) {
            [array addObject:model.currency_name];
        }
        
        [YBPopupMenu showRelyOnView:self.selectCoinLabel titles:array icons:nil menuWidth:160.0 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.delegate = self;
            
        }];
    }];
    [self.selectCoinLabel addGestureRecognizer:tapGes];
    
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        UIImageWriteToSavedPhotosAlbum(self.qrCodeImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    [[self.acopyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        paste.string = self.codeLab.text;
        [self promptReqSuccess:AppLanguageStringWithKey(@"复制成功")];
    }];
    
    
    [self setTheme];
    [self p_requestInfo];
}

- (void)p_requestInfo {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"wallet/wallets" requestMethod:NetWorkMethodGet version:1 parameters:@{@"type":@2} mapModelClass:[XWHomeAssetModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(NSArray *responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.listArray = responseObject;
            NSInteger index = 0;
            for (XWHomeAssetModel *assetModel in self.listArray) {
                if (assetModel.currency_id==self.model.currency_id) {
                    self.index = index;
                }
                index ++;
            }
            
            [self p_updatePageInfo];
        }
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.mj_h;
}

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    self.index = index;
    [self p_updatePageInfo];
}

- (void)p_updatePageInfo {
    XWHomeAssetModel *model = self.listArray[self.index];
    [self.coinImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.coinName.text = model.currency_name;
    CIImage *ciimg = [UIImage creatCodeImageString:model.address];
    UIImage *img = [UIImage creatNonInterpolatedUIImageFormCIImage:ciimg withSize:140];
    self.qrCodeImg.image = img;
    self.codeLab.text = model.address;
    if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageChineseKey]) {
        self.infoLab.text = [NSString stringWithFormat:@"1.禁止向%@地址充值除%@之外的资产，任何充入%@的非%@资产将不可找回。\n2.使用%@地址充值需要2个网络确认才能到账，使用站内间转账无需网络确认，可以实时到账。",model.currency_name,model.currency_name,model.currency_name,model.currency_name,model.currency_name];
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageJapaneseKey]) {
        self.infoLab.text = [NSString stringWithFormat:@"1.ペニキュア損失を防ぐために、%@をアドレスのみに入金してください。\n2.受信するには2ブロック確認が必要で、ブロック確認なしでリアルタイム転送のためにウェブサイト内の転送を使用します。,",model.currency_name];
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageKoreanKey]) {
        self.infoLab.text = [NSString stringWithFormat:@"1. %@ 토큰 주소에서 %@ 토큰 이외의 자산을 위로 하는 것은 금지되어 있으며 %@ 토큰으로 채워진   %@가 아닌 토큰 자산은 복구되지 않습니다. \n2.%@ 토큰 주소를 사용하여 충전하려면 2개의 네트워크 확인이 필요하며, 역 내 전송을 통해 네트워크 확인이 필요하지 않으며 실시간으로 연락할 수 있습니다. ",model.currency_name,model.currency_name,model.currency_name,model.currency_name,model.currency_name];
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageEnglishKey]) {
        self.infoLab.text = [NSString stringWithFormat:@"1.Please deposit %@ only to the address in order to prevent pecuniary loss.。\n2.Requires 2 block confirmation to receive, use transfer within the website for real-time transfer without block confirmation.",model.currency_name];
    }
    
}

- (void)setTheme {
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.coinName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.codeLab.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    
}


@end
