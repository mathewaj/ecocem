//
//  MasterViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "CalculatorViewController.h"
#import "ProjectsGalleryViewController.h"
#import "EcocemIrelandViewController.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize calculatorViewController = _calculatorViewController;
@synthesize projectsGalleryViewController = _projectsGalleryViewController;
@synthesize ecocemIrelandViewController = _ecocemIrelandViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Ecocem", @"Ecocem");
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ecocem-Logo-Transparent.png"]];
        self.navigationItem.titleView = titleImageView;
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-fence.jpg"]];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];

}

- (void)viewDidUnload
{
    [super viewDidUnload];

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)launchCalculator:(id)sender {
    
    if (!self.calculatorViewController) {
        self.calculatorViewController = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.calculatorViewController animated:YES];
    
}
- (IBAction)launchProjectsGallery:(id)sender {
    if (!self.projectsGalleryViewController) {
        self.projectsGalleryViewController = [[ProjectsGalleryViewController alloc] initWithNibName:@"ProjectsGalleryViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.projectsGalleryViewController animated:YES];
}

- (IBAction)launchEcocemIreland:(id)sender {
    if (!self.ecocemIrelandViewController) {
        self.ecocemIrelandViewController = [[EcocemIrelandViewController alloc] initWithNibName:@"EcocemIrelandViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.ecocemIrelandViewController animated:YES];
}


@end
