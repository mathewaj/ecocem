//
//  ProjectsGalleryViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectsGalleryViewController.h"
#import "GalleryViewController.h"

@interface ProjectsGalleryViewController ()

@end

@implementation ProjectsGalleryViewController
@synthesize galleryViewController = _galleryViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Gallery", @"Gallery");
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-fence.jpg"]]; 
        
        // Experimenting with tab bar
        self.tabBarItem.image = [UIImage imageNamed:@"42-photos.png"];
    }
    return self;
}

- (IBAction)launchGallery:(UIButton *)sender {
    if (!self.galleryViewController) {
        self.galleryViewController = [[GalleryViewController alloc] initWithNibName:@"GalleryViewController" bundle:nil];
    }
    if([sender.titleLabel.text isEqualToString:@"Mizen Head Bridge"])
    {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Mizen1.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Mizen2.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Mizen3.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Mizen4.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Mizen5.jpg"]];
    } else {
        self.galleryViewController.photos = nil;
        self.galleryViewController.photos = [[NSMutableArray alloc] init];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina1.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina2.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina3.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina4.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina5.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina6.jpg"]];
        [self.galleryViewController.photos addObject:[UIImage imageNamed:@"Ballina7.jpg"]];
    }
    
    //[self.navigationController pushViewController:self.galleryViewController animated:YES];
    
    // Tab bar experimentation
    [self presentModalViewController:self.galleryViewController animated:YES];
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
