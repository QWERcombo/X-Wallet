//
//  GameVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "GameVC.h"
#import "GameCollectCell.h"
#import "WebVC.h"

@interface GameVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** arr */
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"游戏");
    self.listArray = [NSMutableArray array];
    [self.listArray addObjectsFromArray:@[@{@"title":@"Fortune Bit ",@"type":@"game_3",@"bg":@"game_0"},@{@"title":AppLanguageStringWithKey(@"刮刮乐"),@"type":@"game_5",@"bg":@"game_1"},@{@"title":AppLanguageStringWithKey(@"Dice骰子"),@"type":@"game_4",@"bg":@"game_2"}]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GameCollectCell" bundle:nil] forCellWithReuseIdentifier:@"GameCollectCell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GameCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GameCollectCell" forIndexPath:indexPath];
    
    NSDictionary *dic = [self.listArray objectAtIndex:indexPath.row];

    cell.bgImg.image = [UIImage imageNamed:dic[@"bg"]];
    cell.typeImg.image = [UIImage imageNamed:dic[@"type"]];
    cell.titleImg.text = dic[@"title"];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self jumpToNextVCWithName:indexPath.row];
}

- (void)jumpToNextVCWithName:(NSInteger)name {
    
    WebVC *web = [WebVC new];
    if (name == 1) {
        web.requestUrl = [NSString stringWithFormat:@"http://guaguale.azibalang.info/?token=%@", [UserData.getToken stringByReplacingOccurrencesOfString:@" " withString:@""]];
        [self.navigationController pushViewController:web animated:YES];
    } else if (name == 2) {
        web.requestUrl = [NSString stringWithFormat:@"http://touzi.azibalang.info/?token=%@", [UserData.getToken stringByReplacingOccurrencesOfString:@" " withString:@""]];
        [self.navigationController pushViewController:web animated:YES];
    }
    
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
