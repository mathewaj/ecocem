//
//  CalculatorViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@interface CalculatorViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIScrollViewDelegate, PageControlDelegate>

// Model is three variables for the calculator
@property (nonatomic, strong) NSNumber *concreteQuantity;
@property (nonatomic, strong) NSNumber *cementQuantity;
@property (nonatomic, strong) NSNumber *ggbsQuantity;


// Main view has three textfields
@property (nonatomic, retain) IBOutlet UITextField *textField1;
@property (nonatomic, retain) IBOutlet UITextField *textField2;
@property (nonatomic, retain) IBOutlet UITextField *textField3;


// Accessory view to be added to keypad
@property (nonatomic, retain) UIToolbar *keyboardToolbar;

// Secondary view has an output view with page control
@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) PageControl *pageControl;

// Secondary views have labels
@property (nonatomic, retain) UILabel *co2SavedLabel;
@property (nonatomic, retain) UILabel *energyLabel;
@property (nonatomic, retain) UILabel *pollutantsLabel;

// Methods relating to accessory view
-(void)resignKeyboard:(id)sender;
-(void)previousField:(id)sender;
-(void)nextField:(id)sender;

@end
