//
//  CTLinkLabel.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import UIKit;
#import "RenderedText2.h"

@interface CTLinkLabel : UIView
@property (nonatomic, strong) RenderedText2 *text;

+ (NSAttributedString *)stringWithDataDetected:(NSAttributedString *)string;
@end
