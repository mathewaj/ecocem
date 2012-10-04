//
//  RotatableTabBarViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 19/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RotatableTabBarViewController.h"
#import "GalleryViewController.h"

@interface RotatableTabBarViewController ()

@end

@implementation RotatableTabBarViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Only allow the gallery view controller enter landscape mode
    
    if(self.selectedIndex == 2 && [[[self.viewControllers objectAtIndex:2] visibleViewController] isKindOfClass:[GalleryViewController class]])
        return YES;
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    // Only allow the gallery view controller enter landscape mode
    
    if(self.selectedIndex == 2 && [[[self.viewControllers objectAtIndex:2] visibleViewController] isKindOfClass:[GalleryViewController class]])
        return YES;
    else
        return (orientation == UIInterfaceOrientationPortrait);

}

@end
