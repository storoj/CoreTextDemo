//
//  RenderedTextProtocol.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import CoreGraphics;
@import Foundation;

@protocol RenderedText <NSObject>
- (void)drawInContext:(CGContextRef)ctx;
@end
