//
//  QuestionCell.m
//  HealthAndFitness
//
//  Created by 赵越 on 2019/4/16.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "QuestionCell.h"
#import "QuestionModel.h"

@implementation QuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.displayView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObjc:(id)dataObjc {
    
    QuestionCell *cell = [super initCell:tableView cellName:cellName dataObjc:dataObjc];
    
    QuestionModel *dataModel = (QuestionModel *)dataObjc;
    cell.titleLabel.text = dataModel.title;
    cell.titleLabel.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    cell.contentLabel.text = dataModel.content;
    if (dataModel.isDisplay) {
        cell.statusImgv.image = [UIImage imageNamed:@"show_up"];
        cell.displayView.hidden = NO;
    } else {
        cell.statusImgv.image = [UIImage imageNamed:@"show_down"];
        cell.displayView.hidden = YES;
    }
//    cell.titleLabel.text = dataModel.title;
//    cell.contentLabel.text = dataModel.content;
    
    return cell;
}



@end
