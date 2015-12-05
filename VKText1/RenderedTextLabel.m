//
//  RenderedTextLabel.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "RenderedTextLabel.h"

@implementation RenderedTextLabel

- (void)drawRect:(CGRect)rect {
    [self.text drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)setText:(id<RenderedText>)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
