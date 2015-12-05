//
//  RootViewController.m
//  VKText1
//
//  Created by Alexey Storozhev on 05/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "RootViewController.h"
#import "CTViewController1.h"
#import "CTViewController2.h"
#import "CTViewController3.h"
#import "CTViewController4.h"
#import "CTViewController5.h"
#import "CTBonusViewController.h"

typedef NS_ENUM(NSInteger, MenuOption) {
    MenuOptionSimpleCTLabel,
    MenuOptionRenderedText1,
    MenuOptionRenderedText2,
    MenuOptionRenderedText3,
    MenuOptionRenderedTextLinks,

    MenuOptionCount,
    MenuOptionBonus,
};

static NSString *NSStringFromMenuOption(MenuOption option) {
    switch (option) {
        case MenuOptionSimpleCTLabel:
            return @"Simple CoreText Label";
            
        case MenuOptionRenderedText1:
            return @"Rendered Text 1";
            
        case MenuOptionRenderedText2:
            return @"Rendered Text 2";
            
        case MenuOptionRenderedText3:
            return @"Rendered Text 3";
            
        case MenuOptionRenderedTextLinks:
            return @"Link Label";
            
        case MenuOptionBonus:
            return @"Bonus";
            
        case MenuOptionCount:
            return nil;
    }
}

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MenuOptionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = NSStringFromMenuOption((MenuOption)indexPath.row);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuOption opt = (MenuOption)indexPath.row;
    
    UIViewController *vc = nil;
    switch (opt) {
        case MenuOptionSimpleCTLabel:
            vc = [CTViewController1 new];
            break;
            
        case MenuOptionRenderedText1:
            vc = [CTViewController2 new];
            break;
            
        case MenuOptionRenderedText2:
            vc = [CTViewController3 new];
            break;
            
        case MenuOptionRenderedText3:
            vc = [CTViewController4 new];
            break;
            
        case MenuOptionRenderedTextLinks:
            vc = [CTViewController5 new];
            break;
            
        case MenuOptionBonus:
            vc = [CTBonusViewController new];
            break;
            
        case MenuOptionCount:
            break;
    }
    
    if (vc) {
        vc.title = NSStringFromMenuOption(opt);
        [self.navigationController pushViewController:vc animated:YES];
    }
}
 
@end
