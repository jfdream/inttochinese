//
//  INToChinese.h
//  IntToChinese
//
//  Created by jfdreamyang on 6/20/16.
//  Copyright © 2016 jfdreamyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INToChinese : NSObject
/**
 *  一二三四五六七八九
 *
 *  @param number 转换的数字
 *
 *  @return 中文的文字描述
 */
+(NSString *)toChineseWithInt:(NSInteger)number;
+(NSString *)toTraditionalChineseWithInt:(NSInteger)number;

@end
