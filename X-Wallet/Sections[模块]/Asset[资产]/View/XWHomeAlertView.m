//
//  XWHomeAlertView.m
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "XWHomeAlertView.h"

@interface XWHomeAlertView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *contentView;


@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIButton *getButton;

@property (nonatomic, strong) UILabel *info1Label;

@property (nonatomic, strong) UILabel *info2Label;

@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation XWHomeAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.info1Label];
        [self.contentView addSubview:self.info2Label];
        [self.contentView addSubview:self.totalLabel];
        [self.contentView addSubview:self.getButton];
        [self addSubview:self.closeButton];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0.0);
        }];
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgImageView).mas_offset(30.0);
            make.centerX.mas_equalTo(0.0);
        }];
        
        [_info2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0);
            make.right.mas_equalTo(-10.0);
            make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-20);
        }];
        
        [_info1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.info2Label.mas_top).mas_offset(-12.0);
            make.left.mas_equalTo(10.0);
            make.right.mas_equalTo(-10.0);
        }];
        
        [_getButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-16.0);
            make.bottom.mas_equalTo(0.0);
            make.centerX.mas_equalTo(0.0);
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(52);
        }];
        
        [self addSubview:self.contentView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
        }];
        
        
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(_getButton.mas_bottom).offset(20);
        }];
//        UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
//        self.bgView.userInteractionEnabled = YES;
//        @weakify(self);
//        [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//            @strongify(self);
//            [self removeFromSuperview];
//        }];
//        [self.bgView addGestureRecognizer:tapGes];
        
    }
    return self;
}

- (void)setModel:(XWHomeAlertModel *)model {
    _model = model;
    _totalLabel.text = [NSString stringWithFormat:@"%g XCN",model.number];
    _info1Label.text = AppLanguageStringWithKey(@"今日动态收益");
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6.0;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    _info2Label.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",model.msg1_new.info,model.msg2_new.info] attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
}

- (void)p_getButtonAction {
    [self removeFromSuperview];
}


#pragma mark - lazy load.

- (UIButton *)getButton {
    if (!_getButton) {
        _getButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getButton setTitle:AppLanguageStringWithKey(@"立即领取") forState:UIControlStateNormal];
        [_getButton setTitleColorPicker:IXColorPickerWithRGB(0x062F58,0x062F58,0xB13F00,0xB13F00) forState:UIControlStateNormal];
        if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Christmas"]) {
            _getButton.backgroundColor = [UIColor colorWithHexString:@"#FFDA95"];
        } else {
            [_getButton setBackgroundImage:[UIImage imageNamed:@"home_alert_btn_bg"] forState:UIControlStateNormal];
        }
        [_getButton addTarget:self action:@selector(p_getButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _getButton.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _getButton.layer.cornerRadius = 6;
        _getButton.layer.masksToBounds = YES;
    }
    return _getButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"ass_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        if ([[IXColorMgr defaultMgr].curVersion isEqualToString:@"Christmas"]) {
            _closeButton.hidden = NO;
        } else {
            _closeButton.hidden = YES;
        }
    }
    return _closeButton;
}
- (void)closeClick:(UIButton *)sender {
    [self removeFromSuperview];
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"home_alert_bg"],[UIImage imageNamed:@"home_alert_bg"],[UIImage imageNamed:@"home_alert_bg_2"],[UIImage imageNamed:@"home_alert_bg_3"]);
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.textColorPicker = IXColorPickerWithRGB(0xD2A236,0xD2A236,0xF5DE81,0xF5DE81);
        _totalLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalLabel;
}

- (UILabel *)info2Label {
    if (!_info2Label) {
        _info2Label = [[UILabel alloc] init];
        _info2Label.textColorPicker = IXColorPickerWithRGB(kWhiteR,kWhiteR,0xC8433B,0xC8433B);
        _info2Label.font = [UIFont systemFontOfSize:13];
        _info2Label.numberOfLines =0;
        _info2Label.textAlignment = NSTextAlignmentCenter;
    }
    return _info2Label;
}

- (UILabel *)info1Label {
    if (!_info1Label) {
        _info1Label = [[UILabel alloc] init];
        _info1Label.textColorPicker = IXColorPickerWithRGB(kWhiteR,kWhiteR,0xC61220,0xC61220);
        _info1Label.font = [UIFont systemFontOfSize:20];
        _info1Label.numberOfLines = 0;
        _info1Label.textAlignment = NSTextAlignmentCenter;
    }
    return _info1Label;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _bgView;
}



@end
