//
//  RenderedText2.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import Foundation;
@import CoreGraphics;
#import "RenderedTextProtocol.h"

@interface RenderedText2 : NSObject <RenderedText>

@property (nonatomic, strong, readonly) NSAttributedString *text;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) NSUInteger numberOfLines;
@property (nonatomic, assign, readonly, getter=isTruncated) BOOL truncated;

+ (instancetype)text:(NSAttributedString *)text
               width:(CGFloat)width
       numberOfLines:(NSUInteger)numberOfLines;

- (CFIndex)characterIndexAtPoint:(CGPoint)point;

@end
