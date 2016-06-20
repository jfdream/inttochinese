//
//  main.m
//  IntToChinese
//
//  Created by jfdreamyang on 6/17/16.
//  Copyright © 2016 jfdreamyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "INToChinese.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        while (1) {
            sleep(1);
            NSInteger random=arc4random()%100000000000;
            NSLog(@"%ld====>%@",random,[INToChinese toChineseWithInt:random]);
        }
        
    }
    return 0;
}
