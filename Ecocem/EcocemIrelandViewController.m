//
//  EcocemIrelandViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EcocemIrelandViewController.h"

@interface EcocemIrelandViewController ()

@end

@implementation EcocemIrelandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-fence.jpg"]];
        self.title = @"Info";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Experimenting with tab bar
    self.tabBarItem.image = [UIImage imageNamed:@"info_30.png"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ecocem-Logo-Transparent.png"]];
    self.navigationItem.titleView = titleImageView;
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
- (IBAction)callEcocem:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+353(1)2981453"]];
}

- (IBAction)mailEcocem:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:foo@example.com?subject=Dear%20Ecocem"]];
}

- (IBAction)openEcocemWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ecocem.ie"]];
}

@end
