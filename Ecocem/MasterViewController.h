//
//  MasterViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorViewController;
@class ProjectsGalleryViewController;
@class EcocemIrelandViewController;

@interface MasterViewController : UIViewController

@property (strong, nonatomic) CalculatorViewController *calculatorViewController;
@property (strong, nonatomic) ProjectsGalleryViewController *projectsGalleryViewController;
@property (strong, nonatomic) EcocemIrelandViewController *ecocemIrelandViewController;




@end
