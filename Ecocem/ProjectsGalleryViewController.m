//
//  ProjectsGalleryViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectsGalleryViewController.h"
#import "GalleryViewController.h"
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
        self.title = NSLocalizedString(@"Gallery", @"Gallery");
        self.tabBarItem.image = [UIImage imageNamed:@"42-photos.png"];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
            
            UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Top-Left-Logo.png"]];
            [logoView setFrame:CGRectMake(0, 0, 44, 44)];
            UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithCustomView:logoView];
            
            // Create a negative spacer to go to the left of our custom back button, 
            // and pull it right to the edge:
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] 
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
                                               target:nil action:nil];
            negativeSpacer.width = -5; 
            // Note: We use 5 above b/c that's how many pixels of padding iOS seems to add
            
            // Add the two buttons together on the left:
            self.navigationItem.leftBarButtonItems = [NSArray 
                                                      arrayWithObjects:negativeSpacer, logoItem, nil];
            
        }

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
        self.galleryViewController.detail2 = @"The concrete used in the park incorporated 70% Ecocem, saving over a hundred tonnes of CO2 and providing a superior finish.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Convention Centre"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"2-1hidesmall.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"2-2.png"]];
        self.galleryViewController.detail1 = @"The Convention Centre Dublin is the world’s first carbon neutral convention centre.  The landmark building meets the highest standard of environmental sustainability.";
        self.galleryViewController.detail2 = @"By incorporating 70% Ecocem into the concrete, over 10,500 tonnes of CO2 were saved during the buildings construction.";

    } else if ([sender.titleLabel.text isEqualToString:@"Waterford Bridge"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"3-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"3-2.png"]];
        self.galleryViewController.detail1 = @"The Waterford Cable Stayed Bridge crosses the River Suir and forms part of the N25 Waterford City Bypass.";
        self.galleryViewController.detail2 = @"The concrete piers of this iconic bridge were constructed using 50% Ecocem to ensure the highest technical performance while maintaining an aesthetically pleasing finish.  The increased strength and durability of Ecocem will result in an extended lifespan for the bridge and minimise the need for repair.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"NUI Galway"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"4-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"4-2.png"]];
        self.galleryViewController.detail1 = @"The Engineering Building at NUIG integrates all engineering activities on campus into an exclusive, state of the art academic facility.  The building not only provides a learning environment, but acts as a teaching and learning tool.";
        self.galleryViewController.detail2 = @"The beautifully designed building has won numerous awards, incorporating up to 50% of Ecocem into its construction not only to provide an attractive finish but to highlight the importance of embodied energy to the students.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Wind Farms"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"5-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"5-2.png"]];
        self.galleryViewController.detail1 = @"Using Ecocem at a replacement level of 70% is the best available practice when constructing concrete wind turbine foundations, in terms of cost, strength, durability, and sustainability.";
        self.galleryViewController.detail2 = @"The foundations of many significant wind turbines around Ireland have been constructed using Ecocem enhanced concrete. This has not only improved the environmental credentials of the wind farms but also helped to ensure the integrity of the concrete for years to come.";
        
    } else if ([sender.titleLabel.text isEqualToString:@"Aviva Stadium"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"6-1.png"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"6-2.png"]];
        self.galleryViewController.detail1 = @"The reconstruction of the Aviva Stadium incorporated up to 70% Ecocem in the concrete to reduce the embodied energy and improve the aesthetic qualities.";
        self.galleryViewController.detail2 = @"By using Ecocem 4,000 tonnes of CO2 were saved along with achieving a premium finish in the concrete due to its whiter colour.";
        
    }
    
    [self.navigationController pushViewController:self.galleryViewController animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
