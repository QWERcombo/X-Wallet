//
//  AppLanguageManager.m
//  TestWebProject
//
//  Created by 夏之祥 on 2019/12/6.
//  Copyright © 2019 夏之祥. All rights reserved.
//

#import "AppLanguageManager.h"
#import <objc/runtime.h>

NSString *_Nullable AppLanguageStringWithKey(NSString *_Nonnull key) {
    return [AppLanguageManager getStringWithKey:key];
}
UIImage *_Nullable AppLanguageImageWithKey(NSString *_Nonnull key) {
    return [AppLanguageManager getImageWithKey:key];
}
static const char _bundle = 0;

NSString * const kAppLanguageChineseKey = @"zh-Hans";

NSString * const kAppLanguageEnglishKey = @"en";

NSString * const kAppLanguageJapaneseKey = @"ja";

NSString * const kAppLanguageKoreanKey = @"ko";


static NSString * const kAppUserLanguageKey = @"UserLanguage";

static NSString * const kAppSystemLanguageKey = @"AppleLanguages";

@interface NSBundle (ForLanguage)

+ (void)setLanguage:(kAppLanguageKey)language;

@end


@implementation NSBundle (ForLanguage)

+ (void)setLanguage:(kAppLanguageKey)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [AppLanguageBundle class]);
    });
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language?[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]]:nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface AppLanguageManager ()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation AppLanguageManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static AppLanguageManager *sharedManger = nil;
    dispatch_once(&onceToken, ^{
        sharedManger = [[AppLanguageManager alloc] init];
        
    });
    return sharedManger;
}

+ (NSString *)getStringWithKey:(NSString *)key {
    NSBundle *bundle = AppLanguageManager.shareManager.bundle;
    if (bundle) {
        return NSLocalizedStringFromTableInBundle(key, @"Localizable", bundle, nil);
    }
    return @"";
}

+ (UIImage *)getImageWithKey:(NSString *)key {
    NSBundle *bundle = AppLanguageManager.shareManager.bundle;
    if (bundle) {
        return [UIImage imageNamed:key inBundle:bundle compatibleWithTraitCollection:nil];
    }
    return nil;
}

- (void)initUserLanguage {
    NSString *localeStr = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    kAppLanguageKey languageKey = [userDefaults objectForKey:kAppUserLanguageKey];
    if (!languageKey.length) {
        if ([localeStr isEqualToString:@"en"]) {
            languageKey = kAppLanguageEnglishKey;
        } else if ([localeStr isEqualToString:@"ja"]) {
            languageKey = kAppLanguageJapaneseKey;
        } else if ([localeStr isEqualToString:@"ko"]) {
            languageKey = kAppLanguageKoreanKey;
        } else if ([localeStr isEqualToString:@"th"]) {
            languageKey = kAppLanguageJapaneseKey;
        } else {
            languageKey = kAppLanguageChineseKey;
        }
    }
    [NSBundle setLanguage:languageKey];
    [self setLanguage:languageKey];
    NSString *path = [[NSBundle mainBundle] pathForResource:languageKey ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

- (void)setLanguage:(kAppLanguageKey)language {
    _language = language;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:language forKey:kAppUserLanguageKey];
    [userDefaults synchronize];
    [NSBundle setLanguage:language];
    NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppLanguageChineseKey object:nil];
}

@end

@implementation AppLanguageBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }
    else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end




