//
//  QuestionCell.h
//  HealthAndFitness
//
//  Created by 赵越 on 2019/4/16.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgv;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UILabel *indexLab;

@end

NS_ASSUME_NONNULL_END
