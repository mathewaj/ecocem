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
#import "WebViewController.h"
#import "Reachability.h"


@interface EcocemIrelandViewController ()

@end

@implementation EcocemIrelandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Set title, icon and logo
        self.title = @"Contact";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    return (orientation == UIInterfaceOrientationPortrait);
    
}

- (IBAction)callEcocem:(id)sender {
    BlockAlertView *alert = [BlockAlertView alertWithTitle:nil message:@"+353 (1) 678 1800"];
    
    [alert addButtonWithTitle:@"Call" block:^(void){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+353(1)6781800"]];
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert show];
    
}

- (IBAction)mailEcocem:(id)sender {
    
    // Check for connectivity
    
    if(![self connected])
    {
        [self noConnectionAlert];
        
    } else {
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mfViewController = [[MFMailComposeViewController alloc] init];
            mfViewController.mailComposeDelegate = self;
            [mfViewController setSubject:@"I have a question..."];
            [mfViewController setToRecipients:[NSArray arrayWithObject:@"info@ecocem.ie"]];
            
            [self presentModalViewController:mfViewController animated:YES];
            
        } else {
            
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Status:" message:@"Your phone is not currently configured to send mail."];
            [alert setCancelButtonWithTitle:@"OK" block:nil];
            [alert show];
            
        }
        
    }
    
}

- (IBAction)openEcocemWebsite:(id)sender {
    
    // Check web connection
    if(![self connected])
    {
        [self noConnectionAlert];
        
    } else {
        NSURL *url = [NSURL URLWithString:@"http://www.ecocem.ie"];
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.url = url;
        wvc.pageTitle = @"Ecocem Website";
        [self presentModalViewController:wvc animated:YES];
    }
    
    
    
}


- (IBAction)openEcocemFacebookPage:(id)sender {
    
    // Check web connection
    if(![self connected])
    {
        [self noConnectionAlert];
        
    } else {
        
        // First check if Facebook app available otherwise open page in web view
        NSURL *urlApp = [NSURL URLWithString:@"fb://profile/142727926223"];
        if ([[UIApplication sharedApplication] canOpenURL:urlApp])
        {
            
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Ecocem Facebook" message:@"This will exit the Ecocem app"];
            
            [alert addButtonWithTitle:@"OK" block:^(void){
                [[UIApplication sharedApplication] openURL:urlApp];
            }];
            [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert show];
            
            
        } else {
            
            NSURL *url = [NSURL URLWithString:@"http://www.facebook.com/142727926223"];
            WebViewController *wvc = [[WebViewController alloc] init];
            wvc.url = url;
            wvc.pageTitle = @"Ecocem Facebook";
            [self presentModalViewController:wvc animated:YES];
        }
        
    }
    
    
}

- (IBAction)openEcocemTwitterPage:(id)sender {
    
    // Check web connection
    if(![self connected])
    {
        [self noConnectionAlert];
        
    } else {
        
        // First check if Twitter app available otherwise open page in web view
        NSURL *urlApp = [NSURL URLWithString:@"twitter://user?screen_name=Ecocem"];
        if ([[UIApplication sharedApplication] canOpenURL:urlApp])
        {
            
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Ecocem Twitter" message:@"This will exit the Ecocem app"];
            
            [alert addButtonWithTitle:@"OK" block:^(void){
                [[UIApplication sharedApplication] openURL:urlApp];
            }];
            [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert show];
            
            
        } else {
            
            NSURL *url = [NSURL URLWithString:@"https://twitter.com/Ecocem"];
            WebViewController *wvc = [[WebViewController alloc] init];
            wvc.url = url;
            wvc.pageTitle = @"Ecocem Twitter";
            [self presentModalViewController:wvc animated:YES];
        }
        
    }
    
    
        
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    NSString *message = @"";
    
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
