//
//  ScanViewController.m
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ScanViewController.h"
//工具类
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate>

//捕获会话
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureDevice *device;

//预览图层，可以通过输出设备展示被捕获的数据流
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *scanFrameImageView;

@property (nonatomic, strong) UIButton *openFlashButton;

@property (nonatomic, strong) UIImageView *scannerImageView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.title = AppLanguageStringWithKey(@"扫一扫");

        [self.view addSubview:self.backView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"public_white_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(p_backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.view addSubview:backButton];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = AppLanguageStringWithKey(@"扫一扫");
        [self.view addSubview:titleLabel];
        
        [self.view addSubview:self.scanFrameImageView];
        
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.font = [UIFont systemFontOfSize:15];
        tipsLabel.text = AppLanguageStringWithKey(@"将二维码放入框内即可自动扫描");
        [self.view addSubview:tipsLabel];
        
        [self.view addSubview:self.scannerImageView];
        
        UIView *bottomBackView = [[UIView alloc] init];
        bottomBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self.view addSubview:bottomBackView];
        
        [self.view addSubview:self.openFlashButton];
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5.0);
            make.top.mas_equalTo(self.view.mas_top).mas_offset(5.0);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(backButton);
            make.centerX.mas_equalTo(0.0);
        }];
        
        [_scanFrameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70.0);
            make.right.mas_equalTo(-70.0);
            make.height.mas_equalTo(self.scanFrameImageView.mas_width);
            make.centerY.mas_equalTo(0.0);
        }];
        
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scanFrameImageView.mas_bottom).mas_offset(16.0);
            make.centerX.mas_equalTo(0.0);
        }];
        
        [_scannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scanFrameImageView);
    //        make.centerX.mas_equalTo(0.0);
            make.left.right.mas_equalTo(self.scanFrameImageView);
        }];
        
        [bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0.0);
    //        make.height.mas_equalTo(96.0);
        }];
        
        [_openFlashButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomBackView.mas_top).mas_offset(10.0);
            make.centerX.mas_equalTo(bottomBackView);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-10.0);
        }];
        
        //启动相机
        [self p_setupCamera];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self p_startScannerAnimation];
}

- (void)p_backButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)p_startScannerAnimation {
    //开始动画
    CAKeyframeAnimation *animationMove = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animationMove.values = @[@(0.0),@(CGRectGetHeight(_scanFrameImageView.frame)-CGRectGetHeight(_scannerImageView.frame)),@(0.0)];
    animationMove.duration = 2.5f;
    animationMove.repeatCount = CGFLOAT_MAX;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.scannerImageView.layer addAnimation:animationMove forKey:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //给back添加镂空效果
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_backView.bounds];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:_scanFrameImageView.frame cornerRadius:10.0] bezierPathByReversingPath]];
    shapeLayer.path = path.CGPath;
    _backView.layer.mask = shapeLayer;
}

- (void)p_setupCamera {
    //拍摄设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    //设置输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (error) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:AppLanguageStringWithKey(@"无法使用相机") message:AppLanguageStringWithKey(@"请在iPhone的”设置-隐私-相机”中允许访问相机。") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:AppLanguageStringWithKey(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    
    //设置元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //添加拍摄会话
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    //添加会话输入
    [self.session addInput:input];
    [self.session addOutput:output];
    
    //设置支持类型
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //视频预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_captureInputPortFormatDescriptionDidChangeNotiAction) name:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil];
    
    //开启会话
    [self.session startRunning];
}

- (void)p_captureInputPortFormatDescriptionDidChangeNotiAction {
    //设置扫描范围
    AVCaptureMetadataOutput *output = [self.session.outputs lastObject];
    
    CGRect scanImageViewFrame = CGRectMake(70, (SCREEN_HEIGHT - CGRectGetHeight(_scanFrameImageView.frame)) * 0.5, CGRectGetWidth(_scanFrameImageView.frame), CGRectGetHeight(_scanFrameImageView.frame));
    CGRect scanFrame = [self.previewLayer metadataOutputRectOfInterestForRect:scanImageViewFrame];
    output.rectOfInterest = scanFrame;
}

- (void)p_openFlashButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [_device lockForConfiguration:nil];
    //设置闪光灯为自动
    if ([_device isFlashModeSupported:sender.selected]) {
        [_device setFlashMode:sender.selected];
    }
    if ([_device isTorchModeSupported:sender.selected]) {
        [_device setTorchMode:sender.selected];
    }
    [_session beginConfiguration];
    [_device unlockForConfiguration];
    [_session commitConfiguration];
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *metadataObj in metadataObjects) {
        if ([metadataObj isKindOfClass:[AVMetadataMachineReadableCodeObject class]] && [metadataObj.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self.session stopRunning];
            NSString *scanResult = [(AVMetadataMachineReadableCodeObject *)metadataObj stringValue];
            
            NSString *resultString = scanResult;

#if IENETWORKINGENCRYPTMODE == 1
            NSString *decryptString = [AppAESUtil aes128DecryptWithEncryptString:[[scanResult componentsSeparatedByString:@"?"] firstObject] key:kIENetworkAESKey];
            if (decryptString.length) {
                resultString = decryptString;
            }
#endif
            [self handleScanResult:resultString];
            return;
        }
    }
    
}

- (void)handleScanResult:(NSString *)result {
    if (self.didScanResult) {
        self.didScanResult(self,result);
    }
}

- (void)p_reStartDevice {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.session startRunning];
    });
}

#pragma mark - lazy load.

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = self.view.bounds;
    }
    return _previewLayer;
}

- (UIImageView *)scanFrameImageView {
    if (!_scanFrameImageView) {
        _scanFrameImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"scan_frame"] resizableImageWithCapInsets:UIEdgeInsetsMake(80.0, 80.0, 80.0, 80.0) resizingMode:UIImageResizingModeStretch]];
        _scanFrameImageView.contentMode = UIViewContentModeScaleAspectFill;
        _scanFrameImageView.clipsToBounds = YES;
    }
    return _scanFrameImageView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _backView;
}

- (UIButton *)openFlashButton {
    if (!_openFlashButton) {
        _openFlashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openFlashButton setImage:[UIImage imageNamed:@"scan_bright"] forState:UIControlStateNormal];
        [_openFlashButton setImage:[UIImage imageNamed:@"scan_destroy"] forState:UIControlStateSelected];
        _openFlashButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_openFlashButton addTarget:self action:@selector(p_openFlashButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openFlashButton;
}

- (UIImageView *)scannerImageView {
    if (!_scannerImageView) {
        _scannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_scanner"]];
        _scannerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _scannerImageView.clipsToBounds = YES;
    }
    return _scannerImageView;
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
