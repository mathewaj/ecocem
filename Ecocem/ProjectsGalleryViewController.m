//
//  ProjectsGalleryViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectsGalleryViewController.h"
#import "Version Checking.h"

@interface ProjectsGalleryViewController ()

@end

@implementation ProjectsGalleryViewController

@synthesize galleryViewController = _galleryViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set title and icon
        self.title = @"Gallery";

    }
    return self;
}

- (IBAction)launchGallery:(UIButton *)sender {
    
    self.galleryViewController = [[GalleryViewController alloc] initWithNibName:@"GalleryViewController" bundle:nil];
    if([sender.titleLabel.text isEqualToString:@"Father Collins Park"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"1-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"1-2.png"]];
        self.galleryViewController.detail1 = @"Father Collins Park is Ireland’s first wholly sustainable park. Opened in 2009, the park has the capacity to be entirely self-sufficient.";
        self.galleryViewController.detail2 = @"The concrete used in the park incorporated 70% Ecocem, saving over a hundred tonnes of CO₂ and providing a superior finish.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Convention Centre"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"2-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"2-2.png"]];
        self.galleryViewController.detail1 = @"The Convention Centre Dublin is the world’s first carbon neutral convention centre.  The landmark building meets the highest standard of environmental sustainability.";
        self.galleryViewController.detail2 = @"By incorporating 70% Ecocem into the concrete, over 10,500 tonnes of CO₂ were saved during the building's construction.";

    } else if ([sender.titleLabel.text isEqualToString:@"Waterford Bridge"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"3-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"3-2.png"]];
        self.galleryViewController.detail1 = @"The Waterford Cable Stayed Bridge crosses the River Suir and forms part of the N25 Waterford City Bypass.";
        self.galleryViewController.detail2 = @"The concrete piers of this iconic bridge were constructed using 50% Ecocem saving thousands of tonnes of CO₂ and greatly increasing the lifespan of the bridge.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"NUI Galway"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"4-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"4-2.png"]];
        self.galleryViewController.detail1 = @"The Engineering Building at NUIG integrates all engineering activities on campus into an exclusive, state of the art academic facility.";
        self.galleryViewController.detail2 = @"The beautifully designed building has won numerous awards, incorporating up to 50% Ecocem into its construction not only to provide an attractive finish but to highlight the importance of embodied energy to the students.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Wind Farms"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"5-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"5-2.png"]];
        self.galleryViewController.detail1 = @"Using Ecocem at a replacement level of 70% is the best available practice when constructing concrete wind turbine foundations.";
        self.galleryViewController.detail2 = @"The foundations of many significant wind turbines around Ireland have been constructed using Ecocem enhanced concrete. On average using Ecocem in the base of one wind turbine will save 92 tonnes of CO₂.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Aviva Stadium"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"6-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"6-2.png"]];
        self.galleryViewController.detail1 = @"The reconstruction of the Aviva Stadium incorporated up to 70% Ecocem in the concrete elements. This was done in order to lower the embodied energy of the project and improve the sustainability of the stadium.";
        self.galleryViewController.detail2 = @"By using Ecocem over 4,000 tonnes of CO₂ were saved during the construction of this landmark stadium.";
        
    }
    
    [self.navigationController pushViewController:self.galleryViewController animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    return (orientation == UIInterfaceOrientationPortrait);
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.galleryViewController = nil;

}

@end
