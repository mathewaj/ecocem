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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Only allow the gallery view controller enter landscape mode
    
    if(self.selectedIndex == 2 && [[[self.viewControllers objectAtIndex:2] visibleViewController] isKindOfClass:[GalleryViewController class]])
        return YES;
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
