//
//  CTBonusViewController.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTBonusViewController.h"
@import CoreText;

@implementation CTBonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIFont *font = [UIFont systemFontOfSize:84];
    CTFontRef ctfont = CTFontCreateWithName((__bridge CFStringRef)[font fontName], [font pointSize], NULL);
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"CoreText"
                                                                 attributes:@{ NSFontAttributeName : font }];
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    
    CGFloat x = 10;
    CGFloat y = 200;
    
    for (CFIndex idx=0; idx<CFArrayGetCount(runs); idx++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, idx);
        CFIndex nGlyphs = CTRunGetGlyphCount(run);
        
        CGGlyph glyphs[nGlyphs];
        CTRunGetGlyphs(run, CFRangeMake(0, 0), glyphs);
        
        CGPoint points[nGlyphs];
        CTRunGetPositions(run, CFRangeMake(0, 0), points);
        
        CGFloat ascent, descent, leading;
        CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
        
        const CGFloat lineHeight = ascent+descent+leading;
        
        for (CFIndex glyphIdx=0; glyphIdx<nGlyphs; glyphIdx++) {
            CGAffineTransform t = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, ascent), 1, -1);
            CGPathRef path = CTFontCreatePathForGlyph(ctfont, glyphs[glyphIdx], &t);
            
            CGRect rect = CGPathGetBoundingBox(path);
            
            CAShapeLayer *glyphShape = [[CAShapeLayer alloc] init];
            glyphShape.fillColor = [[UIColor clearColor] CGColor];
            glyphShape.strokeColor = [[UIColor blackColor] CGColor];
            glyphShape.lineWidth = 2;
            glyphShape.strokeEnd = 0.f;
            glyphShape.path = path;
            glyphShape.lineDashPattern = @[ @2, @1 ];
            glyphShape.frame = CGRectMake(0, 0, rect.size.width, lineHeight);
            
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.startPoint = CGPointMake(0.5,1.0);
            gradientLayer.endPoint = CGPointMake(0.5,0.0);
            NSMutableArray *colors = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                [colors addObject:(id)[[UIColor colorWithHue:(0.1 * i) saturation:1 brightness:.8 alpha:1] CGColor]];
            }
            gradientLayer.colors = colors;
            
            gradientLayer.frame = CGRectMake(x, y, rect.size.width + rect.origin.x + 4, lineHeight);
            x = CGRectGetMaxX(gradientLayer.frame);

            gradientLayer.mask = glyphShape;

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * glyphIdx * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.view.layer addSublayer:gradientLayer];
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                animation.fromValue = @(0);
                animation.toValue = @(1);
                animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                animation.duration = 1.f;
                
                [glyphShape addAnimation:animation forKey:nil];
                
                glyphShape.strokeEnd = 1;

            });
        }
    }
    
    CFRelease(line);
    CFRelease(ctfont);
}

@end
