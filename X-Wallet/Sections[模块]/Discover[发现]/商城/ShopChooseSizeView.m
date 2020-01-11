//
//  ShopChooseSizeView.m
//  X-Wallet
//
//  Created by 赵越 on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ShopChooseSizeView.h"
#import "HYStepper.h"

@implementation ShopChooseSizeView {
    HYStepper *stepper;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShopChooseSizeView" owner:self options:nil] firstObject];
        self.showView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
        
        stepper = [[HYStepper alloc] init];
        stepper.maxValue = 10;
        [self addSubview:stepper];
        [stepper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.showView.mas_left);
            make.centerY.equalTo(self.countLab.mas_centerY);
            make.width.mas_offset(100);
            make.height.mas_offset(25);
        }];
        [stepper setValueChanged:^(double value) {
            NSLog(@"%f", value);
        }];
        
        @weakify(self);
        [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (!self.selectBtn) {
                [PromptUtils promptMsg:AppLanguageStringWithKey(@"请选择样式")];
                return ;
            }
            if (self->stepper.value==0) {
                [PromptUtils promptMsg:AppLanguageStringWithKey(@"请选择数量")];
                return;
            }
            
            if (self.sizeBlock) {
                self.sizeBlock(self.selectBtn.currentTitle, self->stepper.value);
                [self removeFromSuperview];
            }
        }];
        
        
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            [self removeFromSuperview];
        }];
        [self addGestureRecognizer:tap];
        UITapGestureRecognizer *tap1 = [UITapGestureRecognizer new];
        [self.contentView addGestureRecognizer:tap1];
        
        self.contentView.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
        self.showName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        self.countLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        self.showSize.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
        
        self.frame = frame;
    }
    return self;
}

- (void)initSizeViewWith:(NSArray *)array {
    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.showView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showView);
    }];
    
    UIView *containerView = [UIView new];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIButton *lastBtn = nil;
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn = [self getButtonWithTitle:array[i]];
        [containerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(10);
            } else {
                make.left.equalTo(containerView.mas_left);
            }
            make.height.mas_offset(25);
            make.width.mas_offset(45);
        }];
        lastBtn = btn;
    }
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastBtn.mas_right);
    }];
}

- (UIButton *)getButtonWithTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 12.5;
    btn.layer.masksToBounds = YES;
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.backgroundColorPicker = IXColorPickerWithRGB(0xefefef,0x2C364E,0xefefef,0xefefef);
    [btn setTitleColor:kMainText9Color forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        
        if (x!=self.selectBtn) {
            self.selectBtn.selected = NO;
            self.selectBtn.backgroundColorPicker = IXColorPickerWithRGB(0xefefef,0x2C364E,0xefefef,0xefefef);
            x.selected = YES;
            x.backgroundColor = kMainColor;
        }
        
        self.selectBtn = x;
    }];
    
    return btn;
}

+ (void)showShopSizeView:(NSDictionary *)dataDic sizeBlock:(SizeBlock)sizeBlock {
    
    ShopChooseSizeView *sizeView = [[ShopChooseSizeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    sizeView.dataDic = dataDic;
    sizeView.sizeBlock = sizeBlock;
    sizeView.showName.text = dataDic[@"title"];
    [sizeView.showImg sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]]];
    sizeView.showPrice.text = [NSString stringWithFormat:@"$%@", dataDic[@"price"]];
    [sizeView initSizeViewWith:dataDic[@"buy_type"]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:sizeView];
}


@end
