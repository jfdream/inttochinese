//
//  INToChinese.m
//  IntToChinese
//
//  Created by jfdreamyang on 6/20/16.
//  Copyright © 2016 jfdreamyang. All rights reserved.
//

#import "INToChinese.h"

@implementation INToChinese
+(NSString *)toChineseWithInt:(NSInteger)value{
    
    NSString * chinese;

    NSArray * zh=@[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    NSArray * unit=@[@"",@"十",@"百",@"千",@"万",@"十万",@"百万",@"千万",@"亿",@"十亿"];
    
    
    NSInteger length=[NSString stringWithFormat:@"%ld",value].length;
    if (length<2) {
        chinese=zh[value];
    }
    else if(length<=4)
    {
        chinese=getBelowTenThousand([NSString stringWithFormat:@"%ld",value], zh, unit);
    }
    else if (length<=8){
        chinese=getBwlow100000000([NSString stringWithFormat:@"%ld",value], zh, unit);
    }
    else if (length<=16){
        
        NSString * my=[NSString stringWithFormat:@"%ld",value];
        
        //低八位计算
        NSInteger lowValue=[[my substringWithRange:NSMakeRange(my.length-8, 8)] integerValue];
        NSString * lowValueStr=[NSString stringWithFormat:@"%ld",lowValue];
        chinese=getBwlow100000000(lowValueStr, zh, unit);
        
        NSInteger highValue=[[my substringWithRange:NSMakeRange(0, my.length-8)] integerValue];
        NSString * highValueStr=[NSString stringWithFormat:@"%ld",highValue];
        NSString * tempStr=getBwlow100000000(highValueStr, zh, unit);//高八位
        
        if (lowValue<10000000) {
            if (lowValue==0) {
                chinese=[NSString stringWithFormat:@"%@亿",tempStr];
            }
            else{
                chinese=[NSString stringWithFormat:@"%@亿零%@",tempStr,chinese];
            }
        }
        else{
            chinese=[NSString stringWithFormat:@"%@亿%@",tempStr,chinese];
        }
    }
    return chinese;
}
+(NSString *)toTraditionalChineseWithInt:(NSInteger)value{
    
    NSString * chinese;
    
    NSArray * zh=@[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray * unit=@[@"",@"拾",@"佰",@"仟",@"萬",@"拾萬",@"佰萬",@"仟萬",@"亿",@"拾亿"];
    
    
    NSInteger length=[NSString stringWithFormat:@"%ld",value].length;
    if (length<2) {
        chinese=zh[value];
    }
    else if(length<=4)
    {
        chinese=getBelowTenThousand([NSString stringWithFormat:@"%ld",value], zh, unit);
    }
    else if (length<=8){
        chinese=getBwlow100000000([NSString stringWithFormat:@"%ld",value], zh, unit);
    }
    else if (length<=16){
        
        NSString * my=[NSString stringWithFormat:@"%ld",value];
        
        //低八位计算
        NSInteger lowValue=[[my substringWithRange:NSMakeRange(my.length-8, 8)] integerValue];
        NSString * lowValueStr=[NSString stringWithFormat:@"%ld",lowValue];
        chinese=getBwlow100000000(lowValueStr, zh, unit);
        
        NSInteger highValue=[[my substringWithRange:NSMakeRange(0, my.length-8)] integerValue];
        NSString * highValueStr=[NSString stringWithFormat:@"%ld",highValue];
        NSString * tempStr=getBwlow100000000(highValueStr, zh, unit);//高八位
        
        if (lowValue<10000000) {
            if (lowValue==0) {
                chinese=[NSString stringWithFormat:@"%@亿",tempStr];
            }
            else{
                chinese=[NSString stringWithFormat:@"%@亿零%@",tempStr,chinese];
            }
        }
        else{
            chinese=[NSString stringWithFormat:@"%@亿%@",tempStr,chinese];
        }
    }
    return chinese;

}
NSString * getBwlow100000000(NSString *ss,NSArray * zh,NSArray * unit){
    NSInteger value=[ss integerValue];
    NSString * rs=[NSString stringWithFormat:@"%ld",value];
    NSInteger length=rs.length;
    if (length<2) {
        return zh[value];
    }
    else if (length<=4){
        
        return getBelowTenThousand(rs, zh, unit);
    }
    NSString * resource=[rs substringWithRange:NSMakeRange(length-4, 4)];
    NSString * chineseE=getBelowTenThousand(resource, zh, unit);
    NSString * chineseS=getBelowTenThousand([[NSString stringWithFormat:@"%ld",value] substringWithRange:NSMakeRange(0, length-4)], zh, unit);
    if ([resource integerValue]<1000&&[resource integerValue]!=0) {
        
        return  [NSString stringWithFormat:@"%@万零%@",chineseS,chineseE];
    }
    else{
        if ([chineseE isEqualToString:@"零"]) {
            return  [NSString stringWithFormat:@"%@万",chineseS];
        }
        else{
            return  [NSString stringWithFormat:@"%@万%@",chineseS,chineseE];
        }
        
    }
}
NSString * getBelowTenThousand(NSString *s,NSArray * zh,NSArray * unit){
    NSInteger value=[s integerValue];
    NSInteger length=[NSString stringWithFormat:@"%ld",value].length;
    NSString * result=@"";
    
    if (length<2) {
        return zh[value];
    }
    for (NSInteger i=length-1; i>=0;i--) {
        
        NSInteger number=value/(pow(10, i));
        value=value-(NSInteger)(pow(10, i)*number);
        if (number==0) {
            if (i>0&&value!=0&&[result hasSuffix:@"零"]==NO) {
                result=[NSString stringWithFormat:@"%@%@",result,zh[0]];
            }
        }
        else{
            result=[NSString stringWithFormat:@"%@%@%@",result,zh[number],unit[i]];
        }
    }
    return result;
}
@end
