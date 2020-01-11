//
//  ShopListVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopListVC.h"
#import "ShopListCell.h"
#import "ShopTypeCell.h"
#import "ShopDetailVC.h"
#import "DiscoverBLL.h"
#import "ShopModel.h"

@interface ShopListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, copy) NSArray *typeArray;
@end

@implementation ShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"商品列表");
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.listArray = [NSMutableArray array];
    self.typeArray = @[@"淘宝",@"Shopee",@"Lazada"];
    [self.collectionView registerClass:[ShopListCell class] forCellWithReuseIdentifier:@"ShopListCell"];
    [self.collectionView registerClass:[ShopTypeCell class] forCellWithReuseIdentifier:@"ShopTypeCell"];
   
    [self getShopList];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.listArray.count;
    } else {
        return self.typeArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ShopListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopListCell" forIndexPath:indexPath];
        
        if (self.listArray.count) {
            [cell setDataObjc:[self.listArray objectAtIndex:indexPath.row]];
        }
        
        return cell;
    } else {
        ShopTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopTypeCell" forIndexPath:indexPath];
        
        cell.shop_name.text = self.typeArray[indexPath.row];
        cell.shop_img.image = [UIImage imageNamed:self.typeArray[indexPath.row]];
        [[[cell.shop_btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"立即进入");
            
        }];
        
        
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((int)((SCREEN_WIDTH-40)/2), 210);
    } else {
        return CGSizeMake((SCREEN_WIDTH-30), 60);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 10, 15);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ShopDetailVC *detail = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"ShopDetailVC"];
        ShopModel *model = [self.listArray objectAtIndex:indexPath.row];
        detail.shop_id = model.shop_id;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}


- (void)getShopList {
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"shop/product" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        [self.collectionView.mj_header endRefreshing];
        NSArray *array = resultDic[@"data"][@"data"];
        
        [self.listArray removeAllObjects];
        for (NSDictionary *dic in array) {
            ShopModel *model = [[ShopModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }

        [self.collectionView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
        [self.collectionView.mj_header endRefreshing];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
        [self.collectionView.mj_header endRefreshing];
    }];
    
}



@end
