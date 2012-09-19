//
//  AppDelegate.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "CalculatorViewController.h"
#import "ProjectsGalleryViewController.h"
#import "EcocemIrelandViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set up first page as info page
    // Navigation controller used to include title navbar
    UIViewController *viewController1 = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    navigationController1.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    // Set up second page as calculator page
    UIViewController *viewController2 = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    navigationController2.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    // Set up third page as gallery page
    UIViewController *viewController3 = [[ProjectsGalleryViewController alloc] initWithNibName:@"ProjectsGalleryViewController" bundle:nil];
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    navigationController3.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    // Set up fourth page as contact page
    UIViewController *viewController4 = [[EcocemIrelandViewController alloc] initWithNibName:@"EcocemIrelandViewController" bundle:nil];
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    navigationController4.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    self.tabBarController = [[RotatableTabBarViewController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController1, navigationController2, navigationController3, navigationController4, nil];
    self.tabBarController.selectedViewController = navigationController1;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
     
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
