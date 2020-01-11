//
//  BaseLanguageModel.m
//  X-Wallet
//
//  Created by 夏之祥 on 2019/12/3.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseLanguageModel.h"

@implementation BaseLanguageModel

- (NSString *)info {
    if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageChineseKey]) {
        return self.zh;
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageJapaneseKey]) {
        return self.jp;
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageKoreanKey]) {
        return self.kor;
    }
    else if ([[AppLanguageManager shareManager].language isEqualToString:kAppLanguageEnglishKey]) {
        return self.en;
    }
    return self.zh;
}

@end
