//
//  ChooseThemeView.h
//  X-Wallet
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseThemeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIButton *nightBtn;
@property (weak, nonatomic) IBOutlet UIButton *christmasBtn;
@property (weak, nonatomic) IBOutlet UIButton *nnewYearBtn;

@property (nonatomic, copy) void(^doneBlock)(void);

+ (void)showThemeViewWithBlock:(void(^)(void))complete;
@end

NS_ASSUME_NONNULL_END
