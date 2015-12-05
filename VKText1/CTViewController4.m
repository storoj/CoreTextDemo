//
//  CTViewController4.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "CTViewController4.h"
#import "RenderedTextLabel.h"
#import "RenderedText2.h"
#import "Utility.h"

@interface CTViewController4 ()
@property (nonatomic, strong) NSArray <NSString *> *texts;
@property (nonatomic, assign) NSUInteger idx;
@property (nonatomic, strong) RenderedTextLabel *label;
@end

@implementation CTViewController4

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
    
    RenderedText2 *renderedText = [RenderedText2 text:attributedText
                                                width:300
                                        numberOfLines:4];
    
    self.label.frame = (CGRect) {
        .origin = CGPointMake(20, 80),
        .size = renderedText.size
    };
    self.label.text = renderedText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.texts = LoadTexts();
    self.view.backgroundColor = [UIColor whiteColor];
    
    RenderedTextLabel *label = [[RenderedTextLabel alloc] initWithFrame:self.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
    self.label = label;
    
    [self.view addSubview:label];
    
    
    [self displayTextAtIndex:0];
}

@end
