//
//  DiscoverViewController.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/20.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "DiscoverViewController.h"
#import "AllTypeVC.h"
#import "DiscoverTypeCell.h"
#import "DiscoverSectionCell.h"
#import "DiscoverSectionView.h"
#import "GameVC.h"
#import "DiscoverBLL.h"
#import "BannerCell.h"
#import "WebVC.h"
#import <WMDragView.h>
#import "InviteVC.h"
#import "ChargeCoinVC.h"
#import "ExtractCoinVC.h"

@interface DiscoverViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/** arr */
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, copy) NSDictionary *classDic;
@property (nonatomic, copy) NSDictionary *webDic;
@property (nonatomic, copy) NSArray *imageArr;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [NSMutableArray array];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = AppLanguageStringWithKey(@"发现");
    label.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.navigationItem.titleView = label;
    
    [self.listArray addObjectsFromArray:@[@{@"title":@"生态应用",@"arr":@[@"充币",@"提币",@"币兑",@"合约",@"商城",@"游戏",@"矿机",@"全部"],@"class":@"DiscoverTypeCell"},@{@"title":@"热门应用",@"arr":@[@"Contract",@"Community",@"Exchange",@"Card"],@"class":@"DiscoverSectionCell"},@{@"title":@"行情资讯",@"arr":@[@"MyToken",@"Bishijie",@"Zuanbi8",@"FN.com",@"Jsgu",@"Feixiaohao"],@"class":@"DiscoverTypeCell"},@{@"title":@"币兑交易所",@"arr":@[@"Biki",@"Binance",@"Huobi",@"Zb.com",@"CoinW",@"Gateio",@"Bittrex",@"Bibox",@"Fubt",@"BTB.io",@"Dfex",@"ZT.com",@"Loex",@"Coinbig",@"KuCoin"],@"class":@"DiscoverTypeCell"},@{@"title":@"区块链浏览器",@"arr":@[@"Omni Explorer",@"BTC.com",@"Etherscan",@"EosPark",@"Tokenview"],@"class":@"DiscoverTypeCell"},@{@"title":@"区块链游戏",@"arr":@[@"Winni",@"Crypto",@"BingBet",@"Endless",@"Big Game",@"Prabos",@"Trust",@"Token Planet"],@"class":@"DiscoverTypeCell"},@{@"title":@"网上商城",@"arr":@[@"兴旺商城",@"禧万福"],@"class":@"DiscoverTypeCell"}]];
    
    [self.collectionView registerClass:[DiscoverTypeCell class] forCellWithReuseIdentifier:@"DiscoverTypeCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DiscoverSectionCell" bundle:nil] forCellWithReuseIdentifier:@"DiscoverSectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DiscoverSectionView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DiscoverSectionView"];
    [self.collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:@"BannerCell"];
    
    /** 拖拽 */
    WMDragView *orangeView = [[WMDragView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT/2, 80, 70)];
    orangeView.imageView.image = [UIImage imageNamed:@"drag_img"];
    orangeView.backgroundColor = [UIColor clearColor];
    orangeView.isKeepBounds = YES;
    [self.view addSubview:orangeView];
    MJWeakSelf
    orangeView.clickDragViewBlock = ^(WMDragView *dragView){
        [self promptMsg:AppLanguageStringWithKey(@"暂未开放")];
    };
    
    WMDragView *orangeView1 = [[WMDragView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT/3, 50, 50)];
    orangeView1.backgroundColor = [UIColor clearColor];
    orangeView1.dragEnable = NO;
    [self.view addSubview:orangeView1];
    orangeView1.clickDragViewBlock = ^(WMDragView *dragView){
        WebVC *web = [WebVC new];
        NSString *urlString = [NSString stringWithFormat:@"http://api.xwallet.vip/h5?token=%@",[UserData.getToken stringByReplacingOccurrencesOfString:@" " withString:@""]];
//        urlString = [[NSString alloc] initWithData:[urlString dataUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];
        
        web.requestUrl = urlString;

//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:web.requestUrl]];
        web.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:web animated:YES];
    };
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lunpan" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:orangeView1.bounds];
    webView.scalesPageToFit = YES;
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    [orangeView1 addSubview:webView];
    
    
    [self getBannerData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.listArray.count+1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        NSArray *arr = self.listArray[section-1][@"arr"];
        return arr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
        if (self.imageArr.count) {
            cell.imageArr = self.imageArr;
        }
        
        return cell;
    } else {
        
        NSArray *array = self.listArray[indexPath.section-1][@"arr"];
        NSString *className = self.listArray[indexPath.section-1][@"class"];
        
        UICollectionViewCell *bcell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
        
        if ([className isEqualToString:@"DiscoverTypeCell"]) {
            DiscoverTypeCell *cell = (DiscoverTypeCell *)bcell;
            if (indexPath.section == 1) {
                cell.typeImg.imagePicker = IXImagePickerWithImages([UIImage imageNamed:[array objectAtIndex:indexPath.row]],[UIImage imageNamed:[NSString stringWithFormat:@"%@N",[array objectAtIndex:indexPath.row]]],[UIImage imageNamed:[array objectAtIndex:indexPath.row]],[UIImage imageNamed:[array objectAtIndex:indexPath.row]]);
            } else {
                cell.typeImg.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
            }
            cell.typeName.text = AppLanguageStringWithKey([array objectAtIndex:indexPath.row]);
            
            
        } else if ([className isEqualToString:@"DiscoverSectionCell"]) {
            NSArray *arr = @[AppLanguageStringWithKey(@"合约"),AppLanguageStringWithKey(@"社区"),AppLanguageStringWithKey(@"币兑"),AppLanguageStringWithKey(@"名片")];
            DiscoverSectionCell *cell = (DiscoverSectionCell *)bcell;
            cell.secImg.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
            cell.secName1.text = AppLanguageStringWithKey([array objectAtIndex:indexPath.row]);
            cell.secName.text = AppLanguageStringWithKey(arr[indexPath.row]);
            cell.layer.cornerRadius = 6;
            cell.layer.masksToBounds = YES;
            
        }
        
        return bcell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 200);
    } else if (indexPath.section == 1) {
        return CGSizeMake((SCREEN_WIDTH-30-40)/4, 80);
    } else {
        NSString *className = self.listArray[indexPath.section-1][@"class"];
        if ([className isEqualToString:@"DiscoverTypeCell"]) {
            return CGSizeMake((SCREEN_WIDTH-30-40)/5, 80);
        } else if ([className isEqualToString:@"DiscoverSectionCell"]) {
            return CGSizeMake((int)(SCREEN_WIDTH-45)/2, 124);
        } else {
            return CGSizeZero;
        }
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    } else {
        NSString *className = self.listArray[section-1][@"class"];
        if ([className isEqualToString:@"DiscoverTypeCell"]) {
             return UIEdgeInsetsMake(10, 15, 10, 15);
        } else if ([className isEqualToString:@"DiscoverSectionCell"]) {
            return UIEdgeInsetsMake(0, 15, 0, 15);
        } else {
            return UIEdgeInsetsZero;
        }
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        NSString *className = self.listArray[section-1][@"class"];
        if ([className isEqualToString:@"DiscoverTypeCell"]) {
             return 15;
        } else if ([className isEqualToString:@"DiscoverSectionCell"]) {
            return 15;
        } else {
            return 0;
        }
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        NSString *className = self.listArray[section-1][@"class"];
        if ([className isEqualToString:@"DiscoverTypeCell"]) {
            return 10;
        } else if ([className isEqualToString:@"DiscoverSectionCell"]) {
            return 15;
        } else {
            return 0;
        }
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        DiscoverSectionView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DiscoverSectionView" forIndexPath:indexPath];
        
        sectionView.titleLab.text = AppLanguageStringWithKey(self.listArray[indexPath.section-1][@"title"]);
        
        return sectionView;
    }
    return [UICollectionReusableView new];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    } else {
        return CGSizeMake(SCREEN_WIDTH, 60);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        /** 跳控制器 */
        NSArray *array = self.listArray[indexPath.section-1][@"arr"];
        NSString *name = array[indexPath.row];
        if ([name isEqualToString:@"Card"]) {
            InviteVC *inviteVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"InviteVC"];
            inviteVC.area_code = UserData.share.currentUser.area_code;
            inviteVC.invitation_code = UserData.share.currentUser.invitation_code;
            inviteVC.invite_url = UserData.share.currentUser.invite_url;
            inviteVC.hidden_phone = UserData.share.currentUser.phone;
            inviteVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:inviteVC animated:YES];
        } else if ([name isEqualToString:@"矿机"]) {
            [self promptMsg:AppLanguageStringWithKey(@"敬请期待")];
        } else {
            [self jumpToNextVCWithName:name];
        }
        
    } else {
        /** 跳Web */
        NSDictionary *dic = self.listArray[indexPath.section-1];
        WebVC *web = [WebVC new];
        web.title = dic[@"arr"][indexPath.row];
        web.requestUrl = self.webDic[web.title];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
    
}

- (void)jumpToNextVCWithName:(NSString *)name {
    
    if ([self.classDic.allKeys containsObject:name]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:self.classDic[name]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([name isEqualToString:@"充币"]) {
        ChargeCoinVC *charge = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ChargeCoinVC"];
        charge.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:charge animated:YES];
    }
    else if ([name isEqualToString:@"提币"]) {
        ExtractCoinVC *extract = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ExtractCoinVC"];
        extract.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:extract animated:YES];
    }
}


- (void)getBannerData {
    
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"home" onSuccess:^(NSDictionary * _Nonnull resultDic) {

        self.imageArr = resultDic[@"data"][@"slide"];
        NSDictionary *info = resultDic[@"data"][@"info"];
        NSError *parse_error = nil;
        UserModel *user = [[UserModel alloc] initWithDictionary:info error:&parse_error];
        UserData.share.currentUser = user;
        [UserData.share saveUserInfo];
        
        [self.collectionView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}


- (NSDictionary *)classDic {
    if (!_classDic) {
        _classDic = [[NSDictionary alloc] initWithObjects:@[@"AllTypeVC",@"GameVC",@"CommunityVC",@"ExchangeCoinVC",@"ContractVC",@"ShopListVC",@"ExchangeCoinVC",@"ContractVC"] forKeys:@[@"全部",@"游戏",@"Community",@"Exchange",@"Contract",@"商城",@"币兑",@"合约"]];
    }
    return _classDic;
}

- (NSDictionary *)webDic {
    if (!_webDic) {
        _webDic = [[NSDictionary alloc] initWithObjects:@[@"https://www.mytoken.io/",@"https://m.bishijie.com",@"https://www.zuanbi8.com",@"https://m.fn.com/",@"https://www.jsgu.cn/",@"https://m.feixiaohao.com/",@"https://www.biki.com",@"https://www.binance.co/cn",@"https://www.huobi.br.com/zh-cn/",@"https://zb.com",@"https://www.coinw.ai/",@"https://gateio.news/",@"https://bittrex.com",@"https://www.bibox365.com/",@"https://www.fubt.com",@"https://www.btb.io",@"https://www.dfex.com",@"https://www.zt.com/",@"https://www.loex.io",@"https://www.coinbig.org/",@"https://www.kcs.top/",@"https://www.omniexplorer.info",@"https://btc.com/",@"https://etherscan.io",@"https://eospark.com/",@"https://tokenview.com/cn/",@"https://tw.8848.game/fcts/",@"https://game.cryptothrone.co/?from=dr10",@"https://bingobet.one/?ref=dappreview239",@"https://eos.endless.game/dice?invite=dappreview23&channel=dappreview100",@"https://eosjacks.com/dappreview236",@"https://chain.pro/web-prabox/#/?ref=dappreview2310",@"https://trustdice.win/?ref=dappreview230",@"http://app.tokenplanet.net/tokenplanet.html?qd=dappreview5",@"http://www.xw020.com/",@"http://www.xiwanfu.com/"] forKeys:@[@"MyToken",@"Bishijie",@"Zuanbi8",@"FN.com",@"Jsgu",@"Feixiaohao",@"Biki",@"Binance",@"Huobi",@"Zb.com",@"CoinW",@"Gateio",@"Bittrex",@"Bibox",@"Fubt",@"BTB.io",@"Dfex",@"ZT.com",@"Loex",@"Coinbig",@"KuCoin",@"Omni Explorer",@"BTC.com",@"Etherscan",@"EosPark",@"Tokenview",@"Winni",@"Crypto",@"BingBet",@"Endless",@"Big Game",@"Prabos",@"Trust",@"Token Planet",AppLanguageStringWithKey(@"兴旺商城"),AppLanguageStringWithKey(@"禧万福")]];
    }
    return _webDic;
}



@end
