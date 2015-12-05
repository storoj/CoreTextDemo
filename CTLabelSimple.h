//
//  CTLabelSimple.h
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

@import UIKit;

@interface CTLabelSimple : UIView
@property (nonatomic, strong) NSAttributedString *attributedText;
@end




typedef NS_ENUM(NSInteger, CTLabelSimpleMode) {
    CTLabelSimpleModeRect,
    CTLabelSimpleModeEllipse,
    CTLabelSimpleModeRectWithHole
};

@interface CTLabelNotSoSimple : CTLabelSimple
@property (nonatomic, assign) CTLabelSimpleMode mode;
@end
