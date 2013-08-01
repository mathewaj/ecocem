//
//  WebViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 10/10/2012.
//
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItemAdded.title = self.pageTitle;
    
    self.navigationBarAdded.tintColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    
    self.webview.scalesPageToFit = YES;
    self.webview.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webview loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (IBAction)doneButtonPushed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.webview.delegate = nil;
    [self setWebview:nil];
    [self setActivityIndicator:nil];
    [self setNavigationBarAdded:nil];
    [self setNavigationItemAdded:nil];
    [super viewDidUnload];
}



@end
