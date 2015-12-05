//
//  RenderedTextLabel.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import UIKit;
#import "RenderedTextProtocol.h"

@interface RenderedTextLabel : UIView
@property (nonatomic, strong) id<RenderedText> text;
@end
