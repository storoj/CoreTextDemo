//
//  CTLabelSimple2.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTLabelSimple2.h"
@import CoreText;

@implementation CTLabelSimple2

- (void)drawRect:(CGRect)rect {
    if (!self.attributedText) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    
//    CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1.f, -1.f)); // FIX
    
    CFAttributedStringRef stringRef = (__bridge CFAttributedStringRef)self.attributedText;
    
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString(stringRef);

    const CGFloat width = CGRectGetWidth(rect);
    const CFIndex textLen = CFAttributedStringGetLength(stringRef);
    const NSUInteger numberOfLines = self.numberOfLines;

    CFIndex startIdx = 0;
    CFIndex lineIdx = 0;
    CGFloat y = 0;

    while (startIdx < textLen && (numberOfLines == 0 || lineIdx < numberOfLines)) {
        CFIndex lineCharactersCount = CTTypesetterSuggestLineBreak(typeSetter, startIdx, width);
        CFIndex endIdx = startIdx + lineCharactersCount;
        CTLineRef line = CTTypesetterCreateLine(typeSetter, CFRangeMake(startIdx, lineCharactersCount));
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CGContextSetTextPosition(ctx, 0, y + ascent);
        CTLineDraw(line, ctx);
        CFRelease(line);
        
        const CGFloat lineHeight = ascent + descent + leading;
        y += lineHeight;
        
        startIdx = endIdx;
        lineIdx++;
    }

    CFRelease(typeSetter);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    [self setNeedsDisplay];
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    [self setNeedsDisplay];
}

@end
