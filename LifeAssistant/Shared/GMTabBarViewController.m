//
//  GMTabBarViewController.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMTabBarViewController.h"
#import "GMViewControllerShared.h"
#import "GMNavigationController.h"
#import "GMConfigurationManager.h"
#import "GMMenuItem.h"
#import "GMViewControllerManager.h"

@interface GMTabBarViewController ()

@end

@implementation GMTabBarViewController

#pragma mark - left cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *menus = [[GMConfigurationManager sharedManager] configMenuItems];
    for (GMMenuItem *menuItem in menus) {
        GMViewControllerShared *childVC = [[GMViewControllerManager sharedManager] createMenuViewControllersWithMenuItem:menuItem];
        childVC.title = menuItem.title;
        childVC.tabBarItem.image = [UIImage imageNamed:menuItem.defaultImage];
        childVC.tabBarItem.selectedImage = [UIImage imageNamed:menuItem.selectedImage];
        GMNavigationController *navi = [[GMNavigationController alloc] initWithRootViewController:childVC];
        [self addChildViewController:navi];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
