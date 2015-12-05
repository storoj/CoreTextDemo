//
//  RenderedText1.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import Foundation;
@import CoreGraphics;
#import "RenderedTextProtocol.h"

@interface RenderedText1 : NSObject <RenderedText>

@property (nonatomic, strong, readonly) NSAttributedString *text;
@property (nonatomic, assign, readonly) CGSize size;

+ (instancetype)text:(NSAttributedString *)text
            maxWidth:(CGFloat)width;

@end
