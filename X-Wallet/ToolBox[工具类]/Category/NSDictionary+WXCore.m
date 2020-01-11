//
//  NSDictionary+WXCore.m
//  X-Wallet
//
//  Created by 夏之祥 on 2019/11/30.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NSDictionary+WXCore.h"

@implementation NSDictionary (WXCore)


- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self p_descriptionWithLevel:level];
}

/**
 将字典转化成字符串，文字格式UTF8,并且格式化
 
 @param level 当前字典的层级，最少为 1，代表最外层字典
 @return 格式化的字符串
 */
- (NSString *)p_descriptionWithLevel:(NSUInteger)level {
    NSString *subSpace = [self p_getSpaceWithLevel:level];
    NSString *space = [self p_getSpaceWithLevel:level?level - 1:0];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 {
    [retString appendString:[NSString stringWithFormat:@"{"]];
    // 2、添加 key = value;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : \"%@\",", subSpace, key, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic p_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            NSString *str = [arr descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 }
    [retString appendString:[NSString stringWithFormat:@"\n%@}", space]];
    return retString;
}

/**
 根据层级，返回前面的空格占位符
 
 @param level 字典的层级
 @return 占位空格
 */
- (NSString *)p_getSpaceWithLevel:(NSUInteger)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (NSUInteger i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}

@end
