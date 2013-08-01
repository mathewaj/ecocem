//
//  MainViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 05/10/2012.
//
//

#import "MainViewController.h"
#import "Version Checking.h"
#import "CalculatorViewController.h"
#import "ProjectsGalleryViewController.h"
#import "EcocemIrelandViewController.h"
#import "MasterViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize button1title = _button1title;
@synthesize button2title = _button2title;
@synthesize button3title = _button3title;
@synthesize button4title = _button4title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Set Ecocem logo image for centre of navbar
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ecocem-Transparent.png"]];
        self.navigationItem.titleView = titleImageView;
        
        // Add logo to left of nav bar for iOS5 upwards
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

- (IBAction)calculatorButtonPushed:(id)sender {
    CalculatorViewController *cvc = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
}
- (IBAction)galleryButtonPushed:(id)sender {
    ProjectsGalleryViewController *pgvc = [[ProjectsGalleryViewController alloc] initWithNibName:@"ProjectsGalleryViewController" bundle:nil];
    [self.navigationController pushViewController:pgvc animated:YES];
}
- (IBAction)contactButtonPushed:(id)sender {
    EcocemIrelandViewController *eivc = [[EcocemIrelandViewController alloc] initWithNibName:@"EcocemIrelandViewController" bundle:nil];
    [self.navigationController pushViewController:eivc animated:YES];
}
- (IBAction)infoButtonPushed:(id)sender {
    MasterViewController *mvc = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)viewDidLoad
{
    // Animate buttons and titles in
    
    [super viewDidLoad];CGRect frame1Start = self.button1.frame;
    CGRect frame1End = frame1Start;
    frame1Start.origin.x -= 150;
    self.button1.frame = frame1Start;
    
    CGRect frame2Start = self.button2.frame;
    CGRect frame2End = frame2Start;
    frame2Start.origin.x += 150;
    self.button2.frame = frame2Start;
    
    CGRect frame3Start = self.button3.frame;
    CGRect frame3End = frame3Start;
    frame3Start.origin.x -= 150;
    self.button3.frame = frame3Start;
    
    CGRect frame4Start = self.button4.frame;
    CGRect frame4End = frame4Start;
    frame4Start.origin.x += 150;
    self.button4.frame = frame4Start;
    
    CGRect titleframe1Start = self.button1title.frame;
    CGRect titleframe1End = titleframe1Start;
    titleframe1Start.origin.x -= 150;
    self.button1title.frame = titleframe1Start;
    
    CGRect titleframe2Start = self.button2title.frame;
    CGRect titleframe2End = titleframe2Start;
    titleframe2Start.origin.x += 150;
    self.button2title.frame = titleframe2Start;
    
    CGRect titleframe3Start = self.button3title.frame;
    CGRect titleframe3End = titleframe3Start;
    titleframe3Start.origin.x -= 150;
    self.button3title.frame = titleframe3Start;
    
    CGRect titleframe4Start = self.button4title.frame;
    CGRect titleframe4End = titleframe4Start;
    titleframe4Start.origin.x += 150;
    self.button4title.frame = titleframe4Start;
    
    [UIView animateWithDuration:1
                     animations:^{
                         self.button1.frame = frame1End;
                         self.button2.frame = frame2End;
                         self.button3.frame = frame3End;
                         self.button4.frame = frame4End;
                         
                         self.button1title.frame = titleframe1End;
                         self.button2title.frame = titleframe2End;
                         self.button3title.frame = titleframe3End;
                         self.button4title.frame = titleframe4End;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
    
    
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidUnload {
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setButton1title:nil];
    [self setButton2title:nil];
    [self setButton3title:nil];
    [self setButton4title:nil];
    [super viewDidUnload];
}
@end
