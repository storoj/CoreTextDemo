//
//  CTViewController3.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTViewController3.h"
#import "CTLabelSimple2.h"
#import "Utility.h"

@interface CTViewController3 ()
@property (nonatomic, strong) NSArray <NSString *> *texts;
@property (nonatomic, assign) NSUInteger idx;
@property (nonatomic, strong) CTLabelSimple2 *label;
@end

@implementation CTViewController3

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                               target:self
                                                                                               action:@selector(actionNext:)];
    }
    return self;
}

- (void)actionNext:(id)sender {
    self.idx = (self.idx+1) % [self.texts count];
    [self displayTextAtIndex:self.idx];
}

- (void)displayTextAtIndex:(NSUInteger)idx {
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName : [UIColor blackColor]
                                 };
    NSString *text = self.texts[idx];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:attributes];
    
    self.label.attributedText = attributedText;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.texts = LoadTexts();
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CTLabelSimple2 *label = [[CTLabelSimple2 alloc] initWithFrame:CGRectMake(20, 80, 300, 300)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    label.numberOfLines = 6;
    label.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
    self.label = label;
    
    [self.view addSubview:label];
    
}

@end