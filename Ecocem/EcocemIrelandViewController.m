//
//  EcocemIrelandViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EcocemIrelandViewController.h"
#import "Version Checking.h"
#import "BlockAlertView.h"


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
    BlockAlertView *alert = [BlockAlertView alertWithTitle:nil message:@"+353 (1) 6670900"];
    
    [alert addButtonWithTitle:@"Call" block:^(void){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+353(1)6670900"]];
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert show];
    
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
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Ecocem Website" message:@"This will exit the Ecocem app"];
    
    [alert addButtonWithTitle:@"OK" block:^(void){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ecocem.ie"]];
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert show];
    
}


- (IBAction)openEcocemFacebookPage:(id)sender {
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Ecocem Facebook" message:@"This will exit the Ecocem app"];
    
    [alert addButtonWithTitle:@"OK" block:^(void){
        // First check if Facebook app available otherwise open page in Safari
        NSURL *urlApp = [NSURL URLWithString:@"fb://profile/142727926223"];
        if ([[UIApplication sharedApplication] canOpenURL:urlApp])
        {
            [[UIApplication sharedApplication] openURL:urlApp];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/142727926223"]];
        }
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert show];
    
    
}

- (IBAction)openEcocemTwitterPage:(id)sender {
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Ecocem Twitter" message:@"This will exit the Ecocem app"];
    
    [alert addButtonWithTitle:@"OK" block:^(void){
        // First check if Twitter app available otherwise open page in Safari
        NSURL *urlApp = [NSURL URLWithString:@"twitter://user?screen_name=Ecocem"];
        //user?screen_name=Ecocem
        //?id=21325242
        if ([[UIApplication sharedApplication] canOpenURL:urlApp])
        {
            [[UIApplication sharedApplication] openURL:urlApp];
            
        } else {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Ecocem"]];
        }
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert show];
    
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    NSString *message = [NSString string];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            message = @"Message Canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            message = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Message Failed";
            break;
        default:
            message = @"Message Not Sent";
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Status:" message:message];
    [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
}

@end
