//
//  OrderSubVC.h
//  X-Wallet
//
//  Created by 赵越 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OrderSubVCDelegate <NSObject>

- (void)refrenTotalMoney:(NSString *)moneyStr;

@end

@class XWCountryModel;
@interface OrderSubVC : BaseTableViewController

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, strong) NSDictionary *shopDic;
@property (nonatomic, copy) NSDictionary *currency;
@property (nonatomic, weak) id<OrderSubVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *shouhuorenTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (strong, nonatomic) XWCountryModel *countryModel;
@end

NS_ASSUME_NONNULL_END
