//
//  PhotoAlertController.m
//  HealthAndFitness
//
//  Created by 赵越 on 2019/4/18.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "PhotoAlertController.h"
#import <CoreServices/CoreServices.h>

@interface PhotoAlertController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIViewController *rootViewController;
@end

@implementation PhotoAlertController {
    UIImagePickerController *_imagePickerController;
}

+(instancetype)initPhotoAlertControllerOnRebackImageBlock:(ReturnPickerImage)pickerImageBlock andRootViewController:(UIViewController *)rootViewController target:(UIView *)target {
    
    PhotoAlertController *photoAC = [super alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    photoAC.rootViewController = rootViewController;
    
    photoAC.pickerImageBlock = pickerImageBlock;
    photoAC.popoverPresentationController.sourceView = target;
    photoAC.popoverPresentationController.sourceRect = target.bounds;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(AppLanguageStringWithKey(@"相机")) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[ToolBox deviceUtils] userCamera:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [photoAC selectImageFromCamera];
            });
        }];
        
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(AppLanguageStringWithKey(@"相册")) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[ToolBox deviceUtils] userAlbum:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [photoAC selectImageFromAlbum];
            });
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(AppLanguageStringWithKey(@"取消")) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [photoAC addAction:camera];
    [photoAC addAction:album];
    [photoAC addAction:cancel];
    
    return photoAC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initImagePickerController];
}


- (void)initImagePickerController {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePickerController.allowsEditing = self.isAllowEdit?YES:NO;
}


#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    //_imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    
    //视频上传质量
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    //设置摄像头模式（拍照，录制视频）
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self.rootViewController presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.rootViewController presentViewController:_imagePickerController animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editImage = nil;
    if (self.isAllowEdit) {
        editImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    } else {
        editImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    if (self.pickerImageBlock) {
        self.pickerImageBlock(editImage);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
//
//
//}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf {
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
