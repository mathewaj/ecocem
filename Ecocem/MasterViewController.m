//
//  MasterViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "Version Checking.h"
#import "BlockAlertView.h"
#import "WebViewController.h"
#import "Reachability.h"

@implementation MasterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Information";
        
    }
    
    return self;
}

- (IBAction)co2ButtonPushed:(id)sender {
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:nil message:@"You would have to drive around the world at the equator 7 times to release this amount of CO₂!!\n\n"];
    [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
    
}
- (IBAction)websiteButtonPushed:(id)sender {
    
    // Check web connection
    if(![self connected])
    {
        [self noConnectionAlert];
        
    } else {
        
        NSURL *url = [NSURL URLWithString:@"http://www.ecocem.ie/environmental,co2.htm"];
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.url = url;
        wvc.pageTitle = @"Ecocem Website";
        [self presentModalViewController:wvc animated:YES];
        
    }
    

    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    return (orientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)noConnectionAlert
{
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Error" message:@"Your device does not have a working internet connection"];
    [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
}


    
    

@end
