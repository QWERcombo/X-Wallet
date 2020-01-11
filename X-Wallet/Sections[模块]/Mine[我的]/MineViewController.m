//
//  MineViewController.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "MineViewController.h"
#import "FaqVC.h"
#import "FeedBackVC.h"
#import "EarnDetailVC.h"
#import "InviteVC.h"
//models
#import "XWUserModel.h"
//utils
#import <SDWebImage/UIImageView+WebCache.h>
#import "YBPopupMenu.h"
#import "AppDelegate.h"
#import "ChooseThemeView.h"

@interface MineViewController ()<YBPopupMenuDelegate>
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
//@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *teamBtn;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
@property (weak, nonatomic) IBOutlet UIButton *taskBtn;
@property (weak, nonatomic) IBOutlet UIView *levelView;
@property (weak, nonatomic) IBOutlet UILabel *levelName;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *languageName;
@property (weak, nonatomic) IBOutlet UILabel *modeName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewToTopConst;

@property (weak, nonatomic) IBOutlet UIImageView *icon0;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIImageView *icon5;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UIImageView *icon6;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *topBgImg;


@property (nonatomic, strong) XWUserModel *model;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = AppLanguageStringWithKey(@"我的");
    self.tableView.tableFooterView = [UIView new];
    self.navigationController.navigationBarHidden = YES;
    self.topBgImg.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_bg"],[UIImage imageNamed:@"min_bg"],[UIImage imageNamed:@"min_bg_2"],[UIImage imageNamed:@"min_bg_3"]);
    self.topViewToTopConst.constant = STATUS_HEIGHT-20;
    
    [self.teamBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.teamBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    [self.inviteBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.inviteBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    [self.taskBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.taskBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    
    self.showView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showView.layer.shadowOpacity = 0.3;
    self.showView.layer.shadowRadius = 6;
    self.showView.layer.shadowOffset = CGSizeMake(1, 1);
    self.showView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    
    self.modeName.text = UserData.share.showModeText;
    
    if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageChineseKey]) {
        self.languageName.text = @"中文";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageJapaneseKey]) {
        self.languageName.text = @"日本語";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageKoreanKey]) {
        self.languageName.text = @"한글";
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageEnglishKey]) {
        self.languageName.text = @"English";
    }
    
    
    [self operate];
    [self setTheme];
    
    [self p_requestInfo];
}

- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon0.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_0"],[UIImage imageNamed:@"min_0N"],[UIImage imageNamed:@"min_0"],[UIImage imageNamed:@"min_0"]);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon1.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_1"],[UIImage imageNamed:@"min_1N"],[UIImage imageNamed:@"min_1"],[UIImage imageNamed:@"min_1"]);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon2.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_2"],[UIImage imageNamed:@"min_2N"],[UIImage imageNamed:@"min_2"],[UIImage imageNamed:@"min_2"]);
    self.label3.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon3.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_3"],[UIImage imageNamed:@"min_3N"],[UIImage imageNamed:@"min_3"],[UIImage imageNamed:@"min_3"]);
    self.label4.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon4.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_4"],[UIImage imageNamed:@"min_4N"],[UIImage imageNamed:@"min_4"],[UIImage imageNamed:@"min_4"]);
    self.label5.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon5.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_5"],[UIImage imageNamed:@"min_5N"],[UIImage imageNamed:@"min_5"],[UIImage imageNamed:@"min_5"]);
    self.label6.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.icon6.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"min_6"],[UIImage imageNamed:@"min_6N"],[UIImage imageNamed:@"min_6"],[UIImage imageNamed:@"min_6"]);
    
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
            self.userName.text = responseObject.nickname;
            self.userID.text = [NSString stringWithFormat:@"ID:%zd",responseObject.id];
            self.levelName.text = responseObject.level_name;
            self.levelName.textColor = [self getLevelColorWithLevel:responseObject.user_level];
            self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"min_level_%zd",self.model.user_level]];
        }
    }];
}

- (UIColor *)getLevelColorWithLevel:(NSInteger)level {
    if (level==0) {
        return HEX_COLOR(@"#999999");
    }
    else if (level==1) {
        return HEX_COLOR(@"#2CB360");
    }
    else if (level==2) {
        return HEX_COLOR(@"#F59469");
    }
    else if (level==3) {
        return HEX_COLOR(@"#FFB63E");
    }
    else if (level==4) {
        return HEX_COLOR(@"#EE163C");
    }
    else if (level==5) {
        return HEX_COLOR(@"#6E718D");
    }
    return nil;
}

- (void)operate {
    
    @weakify(self);
    [[self.exitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self logout];
    }];
    
    [[self.setBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self jumpToNextVC:@"UserInfoVC"];
    }];
    
//    [[self.msgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"消息");
//
//    }];
    
    [[self.teamBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self jumpToNextVC:@"MyTeamVC"];
    }];
    
    [[self.inviteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
//        [self jumpToNextVC:@"InviteVC"];
        InviteVC *inviteVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"InviteVC"];
        inviteVC.area_code = self.model.area_code;
        inviteVC.invitation_code = self.model.invitation_code;
        inviteVC.invite_url = self.model.invite_url;
        inviteVC.hidden_phone = self.model.hidden_phone;
        inviteVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:inviteVC animated:YES];
    }];
    
    [[self.taskBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"任务");
        
    }];
    
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    self.userImg.userInteractionEnabled = YES;
    [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self jumpToNextVC:@"UserInfoVC"];
    }];
    [self.userImg addGestureRecognizer:tapGes];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self jumpToNextVC:@"MyOrderVC"];
    } else if (indexPath.row == 2) {
        [self jumpToNextVC:@"EarnDetailVC"];
    } else if (indexPath.row == 3) {
        [self jumpToNextVC:@"FaqVC"];
    } else if (indexPath.row == 4) {
        [self jumpToNextVC:@"FeedBackVC"];
    } else if (indexPath.row == 5) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [YBPopupMenu showRelyOnView:[cell.contentView.subviews lastObject] titles:@[@"中文",@"English",@"日本語",@"한글"] icons:nil menuWidth:120.0 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.delegate = self;
        }];
        
    } else if (indexPath.row == 6) {
        
        @weakify(self);
        [ChooseThemeView showThemeViewWithBlock:^{
            @strongify(self);
            self.modeName.text = UserData.share.showModeText;
        }];
    } else if (indexPath.row == 7) {
        [self jumpToNextVC:@"AboutUsVC"];
    }
    
}



- (void)jumpToNextVC:(NSString *)className {
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:className];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YBPopupMenuDelegate

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    if (ybPopupMenu.tag == 101) {
        
//        [[IXColorMgr defaultMgr] changeColorVersionWithIndex:(int)index];
//        if (index == 0) {
//            UserData.share.showMode = @"Day";
//        } else {
//            UserData.share.showMode = @"Night";
//        }
//        self.modeName.text = UserData.share.showModeText;
    } else {
        kAppLanguageKey languageKey = nil;
        if (index==0) {
            languageKey = kAppLanguageChineseKey;
        }
        else if (index==1) {
            languageKey = kAppLanguageEnglishKey;
        }
        else if (index==2) {
            languageKey = kAppLanguageJapaneseKey;
        }
        else if (index==3) {
            languageKey = kAppLanguageKoreanKey;
        }
        if (languageKey.length) {
            [[AppLanguageManager shareManager] setLanguage:languageKey];
            AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
            [appDelegate setRootViewController];
        }
    }

}


@end
