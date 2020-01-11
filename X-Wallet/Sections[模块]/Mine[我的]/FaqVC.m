//
//  FaqVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/24.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "FaqVC.h"
#import "QuestionCell.h"
#import "QuestionModel.h"

@interface FaqVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@end

@implementation FaqVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"常见问题");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    
    NSArray *infosArray = @[@{@"title":@"什么是X-WALLET?",@"content":@"X-WALLET是匿名8+1的其中一个生态。",@"isDisplay":@(NO)},
               
                            @{@"title":@"什么是匿名8+1？",@"content":@"匿名8+1是：\ni)匿名钱包 X-WALLET\nii)智能合约 X-TRADE\niii) 支付体系 X-PAYMENT\niv) 商城 X-MALLS\nv) 游戏 X-GAMES\nvi) 矿机 X-MINING\nvii) 匿名主链XCN\nviii) 匿名交易所 X-EXCHANGE + 粉丝体系 X-FANS这是公司的一套的项目规划，也是在这个过程中如何把制作出来的泡沫消掉。目标 ：匿名主链XCN + 匿名交易所 X-EXCHANGE",@"isDisplay":@(NO)},
              
                            @{@"title":@"匿名8+1来自哪里？",@"content":@"匿名8+1来自欧洲爱沙尼亚，科技强国。",@"isDisplay":@(NO)},
               
                            @{@"title":@"匿名8+1 的创办人是谁？",@"content":@"匿名8+1是由欧洲的8大资本方（PlayFair Foundation, Digital Currency Group, Blufolio VC, First Round Capital, Catagonia, Union Square Ventures, Camp One Ventures 和Pantera Capital. ）",@"isDisplay":@(NO)},
               
                            @{@"title":@"海外会员可以注册X-Wallet吗？",@"content":@"可以。 X-Wallet是个全球化的国际项目， 目前中国，香港，台湾，马来西亚，泰国，印度尼西亚，越南，日本，韩国等等国家都有社区。",@"isDisplay":@(NO)},
                        @{@"title":@"论技术，匿名8+1的目标是什么？",@"contnet":@"XCN是基于区块链4.0技术的全匿名基础公链,专注实现隐私和快速处理交易的数字货币吸收了匿名公有链公开透明的优势，融入了ZCash的零知识用户隐私权，并在其区块交易确认上引入了bulletproof防弹协议。",@"isDisplay":@(NO)},
                            @{@"title":@"如今政策管得那么严格，X-Wallet是否会受影响？",@"content":@"不会",@"isDisplay":@(NO)},
                            @{@"title":@"X-Wallet的销毁机制跟XCN的市值有什么关系？",@"content":@"为了提升代币价值，将会通过回购代币销毁的方法，来减少流通量从而提高代币市场价格。因此在销毁机制的刺激下，可流通的XCN总量将会受到影响逐渐降低，而随着市场热度越高，XCN的价值将会受到促进。",@"isDisplay":@(NO)},
              
                            @{@"title":@"如何参与X-Wallet的智能合约？",@"content":@"参与只需要低于100美金；500美金为有效会员。",@"isDisplay":@(NO)},
               
                            @{@"title":@"X-Wallet提币要多久？",@"content":@"T+1。",@"isDisplay":@(NO)},
               
                            @{@"title":@"投资X-Wallet有风险吗？",@"content":@"任何投资都有风险。问题是风险是不是可控的。不同的合约投资金额有大有小，时间有长有短，本金又都是随进随出的，完全可以根据自己的情况灵活投资，风险可控。",@"isDisplay":@(NO)},
               
                            @{@"title":@"X-Wallet合法吗？",@"content":@"不同国家的态度各有不同。就中国来说，虚拟货币也是一种资产，国家不提倡，也不反对。但是提供保护。 ",@"isDisplay":@(NO)}


    ];
    
    self.listArray = [QuestionModel arrayOfModelsFromDictionaries:infosArray error:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionModel *model = [self.listArray objectAtIndex:indexPath.row];
    QuestionCell *cell = [QuestionCell initCell:tableView cellName:@"QuestionCell" dataObjc:model];
    cell.indexLab.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionModel *model = [self.listArray objectAtIndex:indexPath.row];
    
    if (model.isDisplay) {
        
        return UITableViewAutomaticDimension;
    } else {
        
        return 65;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionModel *model = [self.listArray objectAtIndex:indexPath.row];
    model.isDisplay = !model.isDisplay;

    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
