//
//  DetailViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol DetailViewControllerDelegate
- (void)detailViewControllerDidFinish:(DetailViewController *)controller;
@end

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (unsafe_unretained, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (unsafe_unretained, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
