//
//  DDPromptUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "PromptUtils.h"
#import <SVProgressHUD.h>
#import "SVProgressHUD_Extension.h"

@interface PromptUtils()

@property SVProgressHUD *HUD;

@end

@implementation PromptUtils
@synthesize HUD;

+ (PromptUtils *)sharedDDPromptUtils
{
    
    static PromptUtils *ddPromptUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddPromptUtils = [[PromptUtils alloc] init];
        
    });
    
    return ddPromptUtils;
}

+ (void)loading{
    
    [SVProgressHUD setInfoImage:[UIImage imageWithGIFNamed:@"loading"]];
    
    UIImageView *svImgView = [[SVProgressHUD sharedView] valueForKey:@"imageView"];
    CGRect imgFrame = svImgView.frame;
    
    // 设置图片的显示大小
    imgFrame.size = CGSizeMake(50, 50);
    svImgView.frame = imgFrame;
    
    [SVProgressHUD showImage:[SVProgressHUD sharedView].infoImage status:@"loading..."];
//    [SVProgressHUD showWithStatus:@"loading..."];
//    [PromptUtils setSVProgressHUDStyle];
}

+ (void)loadingWithMsg:(NSString *)msg{
    
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [PromptUtils setSVProgressHUDStyle];
}

+ (void)hideLoading{
    
    [SVProgressHUD dismiss];
    [PromptUtils setSVProgressHUDStyle];
}

+ (void)promptMsg:(NSString *)msg{
    
    [PromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
}

+ (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [PromptUtils setSVProgressHUDStyle];
//    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
    
}

+ (void)promptSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [PromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showSuccessWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
}

+ (void)promptError:(NSString *)msg{
    
    [PromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
}

+ (void)setSVProgressHUDStyle{
    
    CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (phoneVersion > 9) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    
}


@end
