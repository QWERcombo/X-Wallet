//
//  FeedBackVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "FeedBackVC.h"
#import "PhotoAlertController.h"

@interface FeedBackVC ()

@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@property (weak, nonatomic) IBOutlet UILabel *hintLab;
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pic1;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UIImageView *pic3;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIView *imgView2;
@property (weak, nonatomic) IBOutlet UIView *imgView3;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label1;


@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"用户反馈");
    self.tableView.tableFooterView = [UIView new];
    self.imageArray = [NSMutableArray array];
    
    self.view.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.inputTV.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.pic1.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.pic2.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.pic3.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.contactTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self operate];
}


- (void)operate {
    @weakify(self);
    [self.inputTV.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.hintLab.hidden = x.length;
    }];
    
    UITapGestureRecognizer *pic1Ges = [UITapGestureRecognizer new];
    [pic1Ges.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        PhotoAlertController *photo = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage * _Nonnull pickerImage) {
            
            
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"上传中")];
            [NetWork uploadImageWithImage:pickerImage completionHandler:^(XWUploadedImageModel * _Nonnull photo, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    
                    //继续请求
                    [self promptReqSuccess:AppLanguageStringWithKey(@"上传成功")];
                    self.pic1.image = pickerImage;
                    self.imgView2.hidden = NO;
                    if (self.imageArray.count>1) {
                        [self.imageArray replaceObjectAtIndex:0 withObject:photo.path];
                    }
                    else {
                        [self.imageArray addObject:photo.path];
                    }
                }
            }];
            
        
        } andRootViewController:self target:self.pic2];
                
        [self presentViewController:photo animated:YES completion:^{
        
        }];
    }];
    self.pic1.userInteractionEnabled = YES;
    [self.pic1 addGestureRecognizer:pic1Ges];
    
    UITapGestureRecognizer *pic2Ges = [UITapGestureRecognizer new];
    [pic2Ges.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        PhotoAlertController *photo = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage * _Nonnull pickerImage) {
            
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"上传中")];
            [NetWork uploadImageWithImage:pickerImage completionHandler:^(XWUploadedImageModel * _Nonnull photo, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    
                    //继续请求
                    [self promptReqSuccess:AppLanguageStringWithKey(@"上传成功")];
                    self.pic2.image = pickerImage;
                    self.imgView3.hidden = NO;
                    if (self.imageArray.count>2) {
                        [self.imageArray replaceObjectAtIndex:1 withObject:photo.path];
                    }
                    else {
                        [self.imageArray addObject:photo.path];
                    }
                }
            }];
            
        
        } andRootViewController:self target:self.pic2];
                
        [self presentViewController:photo animated:YES completion:^{
        
        }];
    }];
    self.pic2.userInteractionEnabled = YES;
    [self.pic2 addGestureRecognizer:pic2Ges];
    
    UITapGestureRecognizer *pic3Ges = [UITapGestureRecognizer new];
    [pic3Ges.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        PhotoAlertController *photo = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage * _Nonnull pickerImage) {
            
            
            
            [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"上传中")];
            [NetWork uploadImageWithImage:pickerImage completionHandler:^(XWUploadedImageModel * _Nonnull photo, NSError * _Nonnull error) {
                
                [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"上传中")];
                [NetWork uploadImageWithImage:pickerImage completionHandler:^(XWUploadedImageModel * _Nonnull photo, NSError * _Nonnull error) {
                    [SVProgressHUD dismiss];
                    if (error) {
                        [self promptMsg:error.localizedDescription];
                    }
                    else {
                        //继续请求
                         [self promptReqSuccess:AppLanguageStringWithKey(@"上传成功")];
                        self.pic3.image = pickerImage;
                        if (self.imageArray.count>3) {
                            [self.imageArray replaceObjectAtIndex:2 withObject:photo.path];
                        }
                        else {
                            [self.imageArray addObject:photo.path];
                        }
                    }
                }];
                
            }];
        
        } andRootViewController:self target:self.pic3];
                
        [self presentViewController:photo animated:YES completion:^{
        
        }];
        
    }];
    self.pic3.userInteractionEnabled = YES;
    [self.pic3 addGestureRecognizer:pic3Ges];
    
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (!self.contactTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入联系方式")];
        }
        else if (!self.inputTV.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入反馈信息")];
        }
        else {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:self.contactTF.text forKey:@"title"];
            [params setObject:self.inputTV.text forKey:@"contents"];
            [params setObject:[self.imageArray componentsJoinedByString:@","] forKey:@"imgs"];
            [NetWork dataTaskWithPath:@"help/helpOrder/submit" requestMethod:NetWorkMethodPost version:1 parameters:params mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [self promptMsg:error.localizedDescription];
                }
                else {
                    [self promptReqSuccess:AppLanguageStringWithKey(@"反馈成功")];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.mj_h;
}

@end
