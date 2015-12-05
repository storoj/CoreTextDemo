//
//  Utility.h
//  VKText1
//
//  Created by Alexey Storozhev on 04/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import Foundation;

extern NSArray <NSString *> *LoadTexts(void);

@interface NSArray <T> (Functional)
- (NSArray *)map:(id(^)(T obj))block;
@end
