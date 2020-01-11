//
//  UserInfoVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UserInfoVC.h"
#import "PhotoAlertController.h"
#import "ModifyNickNameVC.h"
#import "ModifySafeCodeVC.h"
//models
#import "XWUserModel.h"
//utils
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserInfoVC ()

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *uid;
@property (weak, nonatomic) IBOutlet UILabel *inviteCode;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;


@property (nonatomic, strong) XWUserModel *model;

@end

@implementation UserInfoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self p_requestInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"编辑资料");
    self.tableView.tableFooterView = [UIView new];
    
    [UISet setCornerByRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(6, 6) targetView:self.topView viewBounds:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
    [UISet setCornerByRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(6, 6) targetView:self.downView viewBounds:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
        
    [self operate];
    [self setTheme];
}

- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label1.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label2.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label3.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label4.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label5.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label6.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    self.label7.textColorPicker = IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3);
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view2.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.topView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.downView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
}

- (void)p_requestInfo {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"auth/me" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[XWUserModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(XWUserModel *responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.model = responseObject;
            [self.userImg sd_setImageWithURL:[NSURL URLWithString:responseObject.avatar] placeholderImage:[UIImage imageNamed:@"min_user"]];
            self.nickName.text = responseObject.nickname;
            self.uid.text = [NSString stringWithFormat:@"ID:%zd",responseObject.id];
            self.inviteCode.text = responseObject.invitation_code;
        }
    }];
}



- (void)operate {
    
    @weakify(self);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
    [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        
        PhotoAlertController *photo = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage * _Nonnull pickerImage) {
            
            //上传图片
            [SVProgressHUD showWithStatus:@"上传中"];
            [NetWork uploadImageWithImage:pickerImage completionHandler:^(XWUploadedImageModel * _Nonnull photo, NSError * _Nonnull error) {
                if (error) {
                    [SVProgressHUD dismiss];
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    //继续请求
                    [NetWork dataTaskWithPath:@"auth/changeInfo" requestMethod:NetWorkMethodPost version:1 parameters:@{@"type":@"avatar",@"value":photo.path} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                        [SVProgressHUD dismiss];
                        if (error) {
                            [self promptMsg:error.localizedDescription];
                        }
                        else {
                            [self promptReqSuccess:AppLanguageStringWithKey(@"上传成功")];
                            self.userImg.image = pickerImage;
                        }
                    }];
                }
            }];
        
        } andRootViewController:self target:self.userImg];
        
        photo.isAllowEdit = YES;
        
        [self presentViewController:photo animated:YES completion:^{
        
        }];
        
    }];
    [self.userImg addGestureRecognizer:tapGes];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        ModifyNickNameVC *name = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ModifyNickNameVC"];
        name.nickName = self.model.nickname;
        [self.navigationController pushViewController:name animated:YES];
        
    } else if (indexPath.row == 3) {
        
        ModifySafeCodeVC *safe = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ModifySafeCodeVC"];
        [self.navigationController pushViewController:safe animated:YES];
        
    } else if (indexPath.row == 4) {
        NSLog(@"邀请好友");
        
        
    }
    
}

@end
