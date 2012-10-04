//
//  DetailViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize detailDescriptionLabel1 = _detailDescriptionLabel1;
@synthesize detailDescriptionLabel2 = _detailDescriptionLabel2;
@synthesize detail1 = _detail1;
@synthesize detail2 = _detail2;
@synthesize navBar = _navBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Project Info";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissViewController)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.detailDescriptionLabel1.text = self.detail1;
    self.detailDescriptionLabel2.text = self.detail2;
    
    
}

- (IBAction)doneButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.detailDescriptionLabel1 = nil;
    self.detailDescriptionLabel2 = nil;
    self.detail1 = nil;
    self.detail2 = nil;
    self.navBar = nil;
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


							
@end
