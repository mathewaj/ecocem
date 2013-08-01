//
//  CalculatorViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "BlockActionSheet.h"
#import "BlockAlertView.h"
#import "Version Checking.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize concreteQuantity = _concreteQuantity;
@synthesize cementQuantity = _cementQuantity;
@synthesize ggbsQuantity = _ggbsQuantity;

@synthesize textField1 = _textField1;
@synthesize textField2 = _textField2;
@synthesize textField3 = _textField3;
@synthesize keyboardToolbar = _keyboardToolbar;

@synthesize scrollView = _scrollView;
@synthesize resultsBackgroundImageView = _resultsBackgroundImageView;
@synthesize rightDisclosureImageView = _rightDisclosureImageView;

@synthesize co2SavedLabel = _co2SavedLabel;
@synthesize pollutantsLabel = _pollutantsLabel;

#define concreteUnits @"m³"
#define cementUnits @"kg"
#define ggbsUnits @"%"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set title and background pattern
        self.title = @"Calculator";
    }
    return self;
}

-(void)addAccessoryViewToKeyboard
{
    // Add accessory view to number keypad, with Next, Previous and Done buttons
    
    if(self.keyboardToolbar == nil)
    {
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        
        UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] 
                                           initWithTitle:@"Previous" 
                                           style:UIBarButtonItemStyleBordered 
                                           target:self action:@selector(previousField:)];
        
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Next" 
                                       style:UIBarButtonItemStyleBordered 
                                       target:self action:@selector(nextField:)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Done" 
                                       style:UIBarButtonItemStyleDone
                                       target:self action:@selector(resignKeyboard:)];
        
        [self.keyboardToolbar setItems:[[NSArray alloc] initWithObjects:previousButton, nextButton, extraSpace, doneButton, nil]];
        
        
    }
    
    self.textField1.inputAccessoryView = self.keyboardToolbar;
    self.textField2.inputAccessoryView = self.keyboardToolbar;
    self.textField3.inputAccessoryView = self.keyboardToolbar;
    
}

-(void)setUpTextFields
{
    self.textField1.clearsOnBeginEditing = YES;
    self.textField2.clearsOnBeginEditing = YES;
    self.textField3.clearsOnBeginEditing = YES;
    
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    
    self.textField1.placeholder = concreteUnits;
    self.textField2.placeholder = cementUnits;
    self.textField3.placeholder = ggbsUnits;
    
    // Set textfield properties
    self.textField1.backgroundColor = [UIColor clearColor];
    self.textField2.backgroundColor = [UIColor clearColor];
    self.textField3.backgroundColor = [UIColor clearColor];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addAccessoryViewToKeyboard];
    
    [self setUpTextFields];
    
    // Add info button to top right corner
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight]; 
    [infoButton addTarget:self action:@selector(showInfoView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    // Hide results background view at first
    self.resultsBackgroundImageView.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Check if this is the first time viewing the calculator
    // If so show help action sheet to appear
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"])
    {
        [self showActionSheet:nil];
    }
        
}


// Initial tutorial and info button action sheet
- (void)showActionSheet:(id)sender
{
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Use this app to calculate the environmental benefits of using Ecocem \n\n Enter values for your project or use the default values provided\n\n"];
    
    [sheet setDestructiveButtonWithTitle:@"OK" block:nil];
    [sheet addButtonWithTitle:@"Default Values" block:^{
        [self useDefaultValues];
    }];
    [sheet showInView:self.view];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
}

// Info button pushed
- (void)showInfoView:(id)sender
{
    [self showActionSheet:nil];
}


// Called when done button pushed, resigns keyboard
-(void)resignKeyboard:(id)sender
{
    if([self.textField1 isFirstResponder])
    {
        [self.textField1 resignFirstResponder];
    }
    if([self.textField2 isFirstResponder])
    {
        [self.textField2 resignFirstResponder];
    }
    if([self.textField3 isFirstResponder])
    {
        [self.textField3 resignFirstResponder];
    }
    
}

// Called when next button pushed
-(void)nextField:(id)sender
{
    if([self.textField1 isFirstResponder])
    {
        [self.textField2 becomeFirstResponder];
    }
    else if([self.textField2 isFirstResponder])
    {
        [self.textField3 becomeFirstResponder];
    }
    else if([self.textField3 isFirstResponder])
    {
        [self resignKeyboard:nil];
    }
    
}

// Called when previous button pushed
-(void)previousField:(id)sender
{
    if([self.textField2 isFirstResponder])
    {
        [self.textField1 becomeFirstResponder];
    }
    else if([self.textField3 isFirstResponder])
    {
        [self.textField2 becomeFirstResponder];
    }
    
}

-(void)useDefaultValues
{
    [self resignKeyboard:nil];
    self.concreteQuantity = [NSNumber numberWithInt:1000];
    self.cementQuantity = [NSNumber numberWithInt:320];
    self.ggbsQuantity = [NSNumber numberWithInt:50];
    [self updateLabels];
    [self calculateButtonPushed:nil];
}

-(void)updateLabels
{
    self.textField1.text = [[self.concreteQuantity stringValue] stringByAppendingString:@" "];
    self.textField1.text = [self.textField1.text stringByAppendingString:concreteUnits];
    self.textField2.text = [[self.cementQuantity stringValue] stringByAppendingString:@" "];
    self.textField2.text = [self.textField2.text stringByAppendingString:cementUnits];
    self.textField3.text = [[self.ggbsQuantity stringValue] stringByAppendingString:ggbsUnits];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollView.hidden = YES;
    self.resultsBackgroundImageView.hidden = YES;
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // Check GGBS percentage is between 0 and 100
    
    NSString *value = textField.text;
    NSString *units = textField.placeholder;
    
    if([units isEqualToString:ggbsUnits])
    {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *quantity = [f numberFromString:value]; 
        
        int integerValue = [quantity intValue];
        if(integerValue < 0 || integerValue > 100)
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Error" message:@"Please enter a value between 0 and 100"];
            
            [alert setCancelButtonWithTitle:@"OK" block:nil];
            [alert show];
            return NO;
            
        }
    }
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // When text field is finished editing update relevant property with value
    
    NSString *value = textField.text;
    NSString *units = textField.placeholder;
    
    if([textField.text isEqualToString:@""])
    {
        if([units isEqualToString:concreteUnits])
        {
            self.concreteQuantity = nil;
            
        } else if([units isEqualToString:cementUnits])
        {
            self.cementQuantity = nil;
            
        } else if([units isEqualToString:ggbsUnits])
        {
            self.ggbsQuantity = nil;
        }
        
    } else {
        
        // Set value and set textfield text
        
        if([units isEqualToString:concreteUnits])
        {
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle]; 
            self.concreteQuantity = [f numberFromString:value]; 
            
            NSString *displayText = [value stringByAppendingString:@" "];
            displayText = [displayText stringByAppendingString:units];
            textField.text = displayText; 
        } else if([units isEqualToString:cementUnits])
        {
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle]; 
            self.cementQuantity = [f numberFromString:value]; 
            
            NSString *displayText = [value stringByAppendingString:@" "];
            displayText = [displayText stringByAppendingString:units];
            textField.text = displayText; 
        } else if([units isEqualToString:ggbsUnits])
        {
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            self.ggbsQuantity = [f numberFromString:value];
            
            NSString *displayText = [value stringByAppendingString:units];
            textField.text = displayText;
        }
        
    }
}

-(void)loadScrollView
{
    // Scroll view is 2 pages wide
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, 296, 200)];
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    
    scrollView.contentSize = CGSizeMake(width*2, height);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    // Scroll View Scene 1: CO2 emissions
    
    UILabel *co2Label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, 0, width*.8, height*.2)];
    co2Label.textAlignment = UITextAlignmentCenter;
    //co2Label.textColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    co2Label.textColor = [UIColor yellowColor];
    [co2Label setText:@"CO₂ EMISSIONS"];
    co2Label.backgroundColor = [UIColor clearColor];
    co2Label.shadowColor = [UIColor blackColor];
    [scrollView addSubview:co2Label];
    
    self.co2SavedLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, height*0.15, width*.8, height*.85)];
    self.co2SavedLabel.textAlignment = UITextAlignmentCenter;
    //self.co2SavedLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:104.0f/255.0f alpha:1.0];
    self.co2SavedLabel.textColor = [UIColor whiteColor];
    self.co2SavedLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:self.co2SavedLabel];
    
    // Screen View Scene 2: Other Harmful Pollutants

    UILabel *pollutantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1.1, 0, width*.8, height*.3)];
    pollutantsLabel.textAlignment = UITextAlignmentCenter;
    pollutantsLabel.textColor = [UIColor yellowColor];
    pollutantsLabel.shadowColor = [UIColor blackColor];
    pollutantsLabel.numberOfLines = 0;
    [pollutantsLabel setText:@"OTHER HARMFUL POLLUTANTS"];
    pollutantsLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:pollutantsLabel];  
    
    [self.resultsBackgroundImageView addSubview:scrollView];
    self.resultsBackgroundImageView.userInteractionEnabled = YES;
    
    self.pollutantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1.1, height*0.2, width*.8, height*.8)];
    self.pollutantsLabel.textAlignment = UITextAlignmentCenter;
    self.pollutantsLabel.textColor = [UIColor whiteColor];
    self.pollutantsLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:self.pollutantsLabel];
    
    // Set up disclosure buttons
    self.rightDisclosureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(269, self.scrollView.frame.size.height/2-15, 24, 31)];
    self.rightDisclosureImageView.image = [UIImage imageNamed:@"disclosure_arrow.png"];
    self.rightDisclosureImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.rightDisclosureImageView];
    
    // Add tap gesture recogniser to allow scrolling on tap
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arrowPressed)];
    [self.rightDisclosureImageView addGestureRecognizer:tgr];
    
}

-(void)arrowPressed
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
}

- (IBAction)calculateButtonPushed:(UIButton *)sender {
    
    
    // Alert if values have not been entered
    if(!(self.concreteQuantity && self.cementQuantity && self.ggbsQuantity))
    {
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Please ensure all values have been entered"];
        [sheet setDestructiveButtonWithTitle:@"OK" block:nil];
        [sheet showInView:self.view];
        
    } else {
        
        if(self.scrollView==nil)
        {
            // Set up calculator output view
            [self loadScrollView];
        }
        
        self.scrollView.hidden = NO;
        [self.scrollView setContentOffset:CGPointZero animated:NO];
        self.resultsBackgroundImageView.hidden = NO;
        
        // Change values of labels in scroll view
        float concreteValue = [self.concreteQuantity floatValue];
        float cementValue = [self.cementQuantity floatValue];
        float ggbsValue = [self.ggbsQuantity floatValue];
        
        // Update CO2 part of output scroll view
        // CO2 savings: {[kg’s of cement x % GGBS (as a number) x metres cubed concrete]/100000}x0.721 = answer in tonnes (try it at 2 decimal places)
        float co2saved = cementValue * ggbsValue * concreteValue / 100000 * 0.721;
        
        // Equivalent cars: CO2savings/2.2 = answer in cars
        int carsOffTheRoad = roundf(co2saved / 2.2);
        self.co2SavedLabel.numberOfLines = 0;
        self.co2SavedLabel.text = [NSString stringWithFormat:@"%.2f tonnes CO₂ saved\n\nEquivalent to taking\n %i cars off the road per year", co2saved, carsOffTheRoad];
        
        // Update Pollutants part of output scroll view
        
        /*
         NOx: {[kg’s of cement x % GGBS (as a number) x metres cubed concrete]/100000}x1.729 = answer in Kg’s (try it at 2 decimal places)
         SO2: {[kg’s of cement x % GGBS (as a number) x metres cubed concrete]/100000}x0.899987 = answer in Kg’s (try it at 2 decimal places)
         CO: {[kg’s of cement x % GGBS (as a number) x metres cubed concrete]/100000}x1.4931 = answer in Kg’s (try it at 2 decimal places)
         PM10: {[kg’s of cement x % GGBS (as a number) x metres cubed concrete]/100000}x0.006 = answer in Kg’s (try it at 2 decimal places)
         
         */
        
        float so2Savings = cementValue * ggbsValue * concreteValue / 100000 * 1.729;
        float noxSavings = cementValue * ggbsValue * concreteValue / 100000 * 0.899987;
        float coSavings = cementValue * ggbsValue * concreteValue / 100000 * 1.4931;
        float pm10Savings = cementValue * ggbsValue * concreteValue / 100000 * 0.006;
        
         
        self.pollutantsLabel.numberOfLines = 0;
        self.pollutantsLabel.text = [NSString stringWithFormat:@"SO₂ saved: %.2f kg\nNOx saved: %.2f kg\nCO saved: %.2f kg\nPM₁₀ saved: %.2f kg", so2Savings, noxSavings, coSavings, pm10Savings];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.textField1 = nil;
    self.textField2 = nil;
    self.textField3 = nil;
    self.keyboardToolbar = nil;
    
    self.concreteQuantity = nil;
    self.cementQuantity = nil;
    self.ggbsQuantity = nil;
    
    self.textField1 = nil;
    self.textField2 = nil;
    self.textField3 = nil;
    self.keyboardToolbar = nil;
    
    self.scrollView = nil;
    self.resultsBackgroundImageView = nil;
    self.rightDisclosureImageView = nil;
    
    
    self.co2SavedLabel = nil;
    self.pollutantsLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    return (orientation == UIInterfaceOrientationPortrait);
    
}


@end
