//
//  AppLanguageManager.h
//  TestWebProject
//
//  Created by 夏之祥 on 2019/12/6.
//  Copyright © 2019 夏之祥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString *kAppLanguageKey NS_STRING_ENUM;

NSString *_Nullable AppLanguageStringWithKey(NSString *_Nonnull key);
UIImage *_Nullable AppLanguageImageWithKey(NSString *_Nonnull key);


_Nonnull FOUNDATION_EXPORT kAppLanguageKey const kAppLanguageChineseKey;

_Nonnull FOUNDATION_EXPORT kAppLanguageKey const kAppLanguageEnglishKey;

_Nonnull FOUNDATION_EXPORT kAppLanguageKey const kAppLanguageJapaneseKey;

_Nonnull FOUNDATION_EXPORT kAppLanguageKey const kAppLanguageKoreanKey;


NS_ASSUME_NONNULL_BEGIN

@interface AppLanguageManager : NSObject

+ (instancetype)shareManager;

/// 初始化语言
- (void)initUserLanguage;

/// 获取字符串
/// @param key 字符串key
+ (NSString *)getStringWithKey:(NSString *)key;

/// 获取图片
/// @param key 图片
+ (UIImage *)getImageWithKey:(NSString *)key;

/// 当前语言key
@property (nonatomic, strong) kAppLanguageKey language;

@end

@interface AppLanguageBundle : NSBundle

@end


NS_ASSUME_NONNULL_END
