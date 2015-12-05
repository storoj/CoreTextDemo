//
//  CTLinkLabel.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTLinkLabel.h"

static NSString *const kCTLinkLabelLinkAttributeName = @"CTLinkLabelLink";

@implementation CTLinkLabel
{
    RenderedText2 *_highlightedText;
    BOOL _highlighted;
}

+ (NSAttributedString *)stringWithDataDetected:(NSAttributedString *)string {
    static NSDataDetector *dataDetector;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:NULL];
    });
    
    NSMutableAttributedString *text = [string mutableCopy];
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSString *plainText = [string string];
    [dataDetector enumerateMatchesInString:plainText
                                   options:0
                                     range:NSMakeRange(0, [plainText length])
                                usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                    [results insertObject:result atIndex:0];
                                }];
    
    
    [results enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
        
        const NSRange range = [result range];
        NSString *urlString = [plainText substringWithRange:range];
        
        NSString *unescaped = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlString = unescaped ?: urlString;
        
        NSURL *url = [result URL];
        
        [text replaceCharactersInRange:range withString:urlString];
        
        const NSRange replacedRange = NSMakeRange(range.location, [urlString length]);
        [text addAttribute:kCTLinkLabelLinkAttributeName value:url range:replacedRange];
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:replacedRange];
    }];

    return [text copy];
}

- (void)drawRect:(CGRect)rect {
    if (_highlighted && _highlightedText) {
        [_highlightedText drawInContext:UIGraphicsGetCurrentContext()];
    } else {
        [self.text drawInContext:UIGraphicsGetCurrentContext()];
    }
}

- (void)setText:(RenderedText2 *)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RenderedText2 *renderedText = self.text;
    CGPoint p = [[touches anyObject] locationInView:self];
    CFIndex charIdx = [renderedText characterIndexAtPoint:p];
    
    if (charIdx != NSNotFound) {
        NSRange range;
        NSAttributedString *text = renderedText.text;
        NSURL *url = [text attribute:kCTLinkLabelLinkAttributeName atIndex:charIdx effectiveRange:&range];
        
        if (url) {
            
            NSMutableAttributedString *mutableString = [self.text.text mutableCopy];
            [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
            
            RenderedText2 *highlightedText = [RenderedText2 text:mutableString
                                                           width:renderedText.size.width
                                                   numberOfLines:renderedText.numberOfLines];
            
            _highlightedText = highlightedText;
            _highlighted = YES;
            
            [self setNeedsDisplay];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint p = [[touches anyObject] locationInView:self];
    CFIndex charIdx = [self.text characterIndexAtPoint:p];
    if (charIdx != NSNotFound) {
        NSURL *url = [self.text.text attribute:kCTLinkLabelLinkAttributeName
                                       atIndex:charIdx
                                effectiveRange:NULL];
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
    [self cancelHighlight];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelHighlight];
}

- (void)cancelHighlight {
    _highlighted = NO;
    _highlightedText = nil;
    [self setNeedsDisplay];
}


@end
