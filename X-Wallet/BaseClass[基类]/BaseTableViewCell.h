//
//  DDBaseTableViewCell.h
//  DDLife
//
//  Created by 赵越 on 2019/11/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

/**
 TableCell 初始化

 @param tableView tableView
 @param cellName cell类名就行
 @return cell
 */
+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc;


/**
 cell高度

 @return 高度
 */
+ (CGFloat)tableViewHeight;


@end

NS_ASSUME_NONNULL_END
