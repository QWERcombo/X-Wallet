//
//  AllTypeVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AllTypeVC.h"
#import "DiscoverTypeCell.h"
#import "ChargeCoinVC.h"
#import "ExtractCoinVC.h"
@interface AllTypeVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** arr */
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSDictionary *classDic;
@end

@implementation AllTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"全部");
    self.listArray = [NSMutableArray array];
    [self.listArray addObjectsFromArray:@[AppLanguageStringWithKey(@"充币"),AppLanguageStringWithKey(@"提币"),AppLanguageStringWithKey(@"收款"),AppLanguageStringWithKey(@"付款"),AppLanguageStringWithKey(@"币兑"),AppLanguageStringWithKey(@"合约"),AppLanguageStringWithKey(@"商城"),AppLanguageStringWithKey(@"游戏"),AppLanguageStringWithKey(@"交易所"),AppLanguageStringWithKey(@"社区"),AppLanguageStringWithKey(@"投票"),AppLanguageStringWithKey(@"生态")]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DiscoverTypeCell" bundle:nil] forCellWithReuseIdentifier:@"DiscoverTypeCell"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverTypeCell" forIndexPath:indexPath];
    
    cell.typeImg.imagePicker = IXImagePickerWithImages([UIImage imageNamed:[self.listArray objectAtIndex:indexPath.row]],[UIImage imageNamed:[NSString stringWithFormat:@"%@N",[self.listArray objectAtIndex:indexPath.row]]],[UIImage imageNamed:[self.listArray objectAtIndex:indexPath.row]],[UIImage imageNamed:[self.listArray objectAtIndex:indexPath.row]]);
    cell.typeName.text = [self.listArray objectAtIndex:indexPath.row];
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (SCREEN_WIDTH-240-30)/3.0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self jumpToNextVCWithName:self.listArray[indexPath.row]];
}

- (void)jumpToNextVCWithName:(NSString *)name {
    NSLog(@"%@", name);
    if ([name isEqualToString:AppLanguageStringWithKey(@"充币")]) {
        ChargeCoinVC *charge = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ChargeCoinVC"];
        [self.navigationController pushViewController:charge animated:YES];
    }
    else if ([name isEqualToString:AppLanguageStringWithKey(@"提币")]) {
        ExtractCoinVC *extract = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ExtractCoinVC"];
        [self.navigationController pushViewController:extract animated:YES];
    }
    if ([self.classDic.allKeys containsObject:name]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:self.classDic[name]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([name isEqualToString:AppLanguageStringWithKey(@"充币")]) {
        
    } else if ([name isEqualToString:AppLanguageStringWithKey(@"提币")]) {
        
    } else {
        [self promptMsg:AppLanguageStringWithKey(@"敬请期待")];
    }

}


- (NSDictionary *)classDic {
    if (!_classDic) {
        _classDic = [[NSDictionary alloc] initWithObjects:@[@"GameVC",@"CommunityVC",@"ExchangeCoinVC",@"ContractVC",@"ShopListVC",@"ExchangeCoinVC",@"ContractVC"] forKeys:@[AppLanguageStringWithKey(@"游戏"),@"Community",@"Exchange",@"Contract",AppLanguageStringWithKey(@"商城"),AppLanguageStringWithKey(@"币兑"),AppLanguageStringWithKey(@"合约")]];
    }
    return _classDic;
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
