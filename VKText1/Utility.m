//
//  Utility.m
//  VKText1
//
//  Created by Alexey Storozhev on 04/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "Utility.h"

NSArray <NSString *> *LoadTexts(void)
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"posts" ofType:@"json"]];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}


@implementation NSArray(Functional)

- (NSArray *)map:(id (^)(id))block {
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self) {
        [result addObject:block(obj)];
    }
    return [result copy];
}

@end
