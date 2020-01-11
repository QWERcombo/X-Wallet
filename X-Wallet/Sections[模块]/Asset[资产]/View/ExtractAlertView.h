//
//  ExtractAlertView.h
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtractAlertView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *showInfo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

+ (ExtractAlertView *)showExtractAlertViewWithInfo:(NSString *)infoStr address:(NSString *)addressStr time:(NSString *)timeStr status:(NSString *)statusStr;
@end

NS_ASSUME_NONNULL_END
