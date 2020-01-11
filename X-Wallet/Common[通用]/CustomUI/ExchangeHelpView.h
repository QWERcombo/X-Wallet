//
//  ExchangeHelpView.h
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeHelpView : UIView

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

+ (void)showHelpViewWithContent:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
