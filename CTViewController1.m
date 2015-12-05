//
//  CTViewController1.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTViewController1.h"
#import "CTLabelSimple.h"
#import "Utility.h"

@implementation CTViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CTLabelSimple *label = [[CTLabelSimple alloc] initWithFrame:CGRectMake(20, 80, 300, 300)];
    NSString *text = [LoadTexts() firstObject];

    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName : [UIColor blackColor]
                                 };
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:attributes];

    label.attributedText = attributedText;
    label.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
    
    [self.view addSubview:label];
    
}

@end
