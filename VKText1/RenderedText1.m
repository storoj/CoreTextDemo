//
//  RenderedText1.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "RenderedText1.h"
@import CoreText;

static const CGFloat HUGE_HEIGHT = 10e7;

static CGSize CTFrameSize(CTFrameRef frame, CGSize constraintSize) {

    CFArrayRef lines = CTFrameGetLines(frame);
    const CFIndex numberOfLines = CFArrayGetCount(lines);
    
    if (numberOfLines == 0) {
        return CGSizeZero;
    }
    
    const CFIndex lastLineIdx = numberOfLines-1;
    CGPoint lastLineOrigin;
    CTFrameGetLineOrigins(frame, CFRangeMake(lastLineIdx, 1), &lastLineOrigin);
    
    CTLineRef lastLine = CFArrayGetValueAtIndex(lines, lastLineIdx);
    
    CGFloat descent, leading;
    CTLineGetTypographicBounds(lastLine, NULL, &descent, &leading);
    
    return CGSizeMake(constraintSize.width, constraintSize.height-lastLineOrigin.y+descent+leading);
}

static CTFrameRef CTFrameWithConstraints(CFAttributedStringRef string, CGSize maxSize) {
    CGRect rect = { CGPointZero, maxSize };
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CFRelease(framesetter);
    CFRelease(path);
    
    return frame;
}

@interface RenderedText1 ()
@property (nonatomic, assign) CTFrameRef frame;
@property (nonatomic, assign) CGSize constraintSize;
@end

@implementation RenderedText1

- (void)dealloc {
    if (_frame) {
        CFRelease(_frame);
    }
}

- (instancetype)initWithText:(NSAttributedString *)text frame:(CTFrameRef)frame constraintSize:(CGSize)constraintSize {
    self = [super init];
    if (self) {
        _text = [text copy];
        _frame = frame;
        _constraintSize = constraintSize;
        _size = CTFrameSize(frame, constraintSize);
    }
    return self;
}

+ (instancetype)text:(NSAttributedString *)text
            maxWidth:(CGFloat)width
{
    CGSize maxSize = CGSizeMake(width, HUGE_HEIGHT);
    CFAttributedStringRef string = (__bridge CFAttributedStringRef)text;
    CTFrameRef frame = CTFrameWithConstraints(string, maxSize);
    return [[self alloc] initWithText:text frame:frame constraintSize:maxSize];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.constraintSize.height);
    CGContextScaleCTM(ctx, 1.f, -1.f);

    CTFrameDraw(self.frame, ctx);
}

@end
