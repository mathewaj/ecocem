//
//  WebViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 10/10/2012.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

// Model is a url
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *pageTitle;

// View is a webview
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationBar *navigationBarAdded;
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationItem *navigationItemAdded;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webview;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



@end
