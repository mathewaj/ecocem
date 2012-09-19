//
//  EcocemIrelandViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EcocemIrelandViewController.h"
#import "Version Checking.h"


@interface EcocemIrelandViewController ()

@end

@implementation EcocemIrelandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Set title, icon and logo
        self.title = @"Contact";
        self.tabBarItem.image = [UIImage imageNamed:@"75-phone.png"];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
            
            UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ecocem-Logo-Icon.png"]];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
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
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mfViewController = [[MFMailComposeViewController alloc] init];
        mfViewController.mailComposeDelegate = self;
        [mfViewController setSubject:@"Ecocem Query"];
        [mfViewController setToRecipients:[NSArray arrayWithObject:@"info@ecocem.ie"]];
        
        [self presentModalViewController:mfViewController animated:YES];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status:" message:@"Your phone is not currently configured to send mail." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
        [alert show];

    }
    
    
}

- (IBAction)openEcocemWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ecocem.ie"]];
}

- (IBAction)openEcocemMap:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ecocem.ie"]];
}

- (IBAction)openEcocemFacebookPage:(id)sender {
    
    // First check if Facebook app available otherwise open page in Safari
    NSURL *urlApp = [NSURL URLWithString:@"fb://profile/142727926223"];
    if ([[UIApplication sharedApplication] canOpenURL:urlApp])
    {
        [[UIApplication sharedApplication] openURL:urlApp];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/142727926223"]];
    }
}

- (IBAction)openEcocemTwitterPage:(id)sender {
    
    // First check if Twitter app available otherwise open page in Safari
    NSURL *urlApp = [NSURL URLWithString:@"twitter://profile/21325242"];
    if ([[UIApplication sharedApplication] canOpenURL:urlApp])
    {
        [[UIApplication sharedApplication] openURL:urlApp];
        
    } else {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Ecocem"]];
    }
    
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status:" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            alert.message = @"Message Canceled";
            break;
        case MFMailComposeResultSaved:
            alert.message = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            alert.message = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            alert.message = @"Message Failed";
            break;
        default:
            alert.message = @"Message Not Sent";
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    [alert show];
}

@end
