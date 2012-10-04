//
//  DetailViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel1;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel2;

@property (strong, nonatomic) NSString *detail1;
@property (strong, nonatomic) NSString *detail2;

@property (unsafe_unretained, nonatomic) IBOutlet UINavigationBar *navBar;

@end
