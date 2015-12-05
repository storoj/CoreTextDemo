//
//  CTLabelSimple.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTLabelSimple.h"
@import CoreText;

@implementation CTLabelSimple

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    uncomment to fix
//    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//    CGContextTranslateCTM(ctx, 0, CGRectGetMaxY(rect));
//    CGContextScaleCTM(ctx, 1.f, -1.f);

    CFAttributedStringRef string = (__bridge CFAttributedStringRef)self.attributedText;
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attributedText.length), path, NULL);
    CTFrameDraw(frame, ctx);
    
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    [self setNeedsDisplay];
}

@end



@implementation CTLabelNotSoSimple

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, CGRectGetMaxY(rect));
    CGContextScaleCTM(ctx, 1.f, -1.f);
    
    CFAttributedStringRef string = (__bridge CFAttributedStringRef)self.attributedText;
    CGPathRef path = nil;
    
    switch (self.mode) {
        case CTLabelSimpleModeRect:
            path = CGPathCreateWithRect(rect, NULL);
            break;
            
        case CTLabelSimpleModeEllipse:
            path = CGPathCreateWithEllipseInRect(rect, NULL);
            break;
            
        case CTLabelSimpleModeRectWithHole:
        {
            UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:rect];
            [bpath appendPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, CGRectGetWidth(rect)/4, CGRectGetHeight(rect)/4)] bezierPathByReversingPath]];
            
            path = CGPathCreateCopy([bpath CGPath]);
            break;
        }
            
    }
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attributedText.length), path, NULL);
    CTFrameDraw(frame, ctx);
    
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

- (void)setMode:(CTLabelSimpleMode)mode {
    _mode = mode;
    [self setNeedsDisplay];
}

@end