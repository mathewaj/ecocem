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

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize concreteQuantity = _concreteQuantity;
@synthesize cementQuantity = _cementQuantity;
@synthesize ggbsQuantity = _ggbsQuantity;
@synthesize pageControl = _pageControl;

@synthesize textField1 = _textField1;
@synthesize textField2 = _textField2;
@synthesize textField3 = _textField3;
@synthesize keyboardToolbar = _keyboardToolbar;

@synthesize scrollView = _scrollView;

@synthesize co2SavedLabel = _co2SavedLabel;
@synthesize energyLabel = _energyLabel;
@synthesize pollutantsLabel = _pollutantsLabel;


// Set the coefficents separately from the rest of the code

float co2Coefficient = 129.6 / 16000000;
float carCoefficent = 41.6 / 16000000;
float treesCoefficent = 40.8 / 16000000;

float so2Saved = 400.0 / 16000000;
float noxSaved = 560.0 / 16000000;
float coSaved = 400.0 / 16000000;
float pm10Saved = 69.7 / 16000000;

float energySaved = 553000.0 / 16000000;
float averageHomes = 28.5 / 16000000;

BOOL pageControlBeingUsed;

#define concreteUnits @"cubic metres"
#define cementUnits @"kg"
#define ggbsUnits @"% GGBS"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set title and background pattern
        self.title = NSLocalizedString(@"Calculator", @"Calculator");
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-fence.jpg"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    self.textField1.clearsOnBeginEditing = YES;
    self.textField2.clearsOnBeginEditing = YES;
    self.textField3.clearsOnBeginEditing = YES;
    
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    
    self.textField1.placeholder = concreteUnits;
    self.textField2.placeholder = cementUnits;
    self.textField3.placeholder = ggbsUnits;
    
    
    pageControlBeingUsed = NO;
    
    // Add info button to top right corner

    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight]; 
    [infoButton addTarget:self action:@selector(showInfoView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    // Experimenting with tab bar
    self.tabBarItem.image = [UIImage imageNamed:@"161-calculator.png"];
}

// Show info page when view appears
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showActionSheet:nil];
    
}


// Initial tutorial and info button action sheet
- (void)showActionSheet:(id)sender
{
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"This is a carbon calculator which allows you to calculate the environmental benefits of using Ecocem in your project. \n\n Enter values for your project or use the default value button below.\n"];
    [sheet setDestructiveButtonWithTitle:@"OK" block:nil];
    [sheet addButtonWithTitle:@"Use Default Values" block:^{
        [self useDefaultValues];
    }];
    [sheet showInView:self.view];
}

// Info button pushed
- (void)showInfoView:(id)sender
{
    [self showActionSheet:nil];
}

- (void)viewDidUnload
{
    [self setPageControl:nil];
    [super viewDidUnload];
    self.textField1 = nil;
    self.textField2 = nil;
    self.textField3 = nil;
    self.keyboardToolbar = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    // Flash calculate button if all three fields populated
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
    self.concreteQuantity = [NSNumber numberWithInt:1000];
    self.cementQuantity = [NSNumber numberWithInt:320];
    self.ggbsQuantity = [NSNumber numberWithInt:20];
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
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
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
    if([textField.text isEqualToString:@""])
    {
        // leave clear for now
        
    } else {
        
        // Set value and set textfield text
        
        NSString *value = textField.text;
        NSString *units = textField.placeholder;
        
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
    // Scroll view is 3 pages wide
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*.5, self.view.frame.size.width, self.view.frame.size.height*.65)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height/2);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    
    // Scroll View Scene 1: CO2 emissions
    // Text equivalent to kilogrammes of CO2
    // Image cars with exhaust fumes
    
    UILabel *co2Label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, 0, scrollView.frame.size.width*.8, scrollView.frame.size.height*.2)];
    co2Label.textAlignment = UITextAlignmentCenter;
    co2Label.textColor = [UIColor whiteColor];
    [co2Label setText:@"CO2 EMISSIONS"];
    co2Label.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:co2Label];
    
    self.co2SavedLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, height*0.2, scrollView.frame.size.width*.8, scrollView.frame.size.height*.4)];
    self.co2SavedLabel.textAlignment = UITextAlignmentCenter;
    self.co2SavedLabel.textColor = [UIColor whiteColor];
    self.co2SavedLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:self.co2SavedLabel];
    
    // Scroll View Scene 2: Energy Used
    // Text equivalent to quantities of gases
    // Image power plant with smoke
    
    UILabel *energyLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1.1, 0, scrollView.frame.size.width*.8, scrollView.frame.size.height*.2)];
    energyLabel.textAlignment = UITextAlignmentCenter;
    energyLabel.textColor = [UIColor whiteColor];
    [energyLabel setText:@"ENERGY"];
    energyLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:energyLabel];
    
    self.energyLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1.1, height*0.2, scrollView.frame.size.width*.8, scrollView.frame.size.height*.4)];
    self.energyLabel.textAlignment = UITextAlignmentCenter;
    self.energyLabel.textColor = [UIColor whiteColor];
    self.energyLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:self.energyLabel];
        
    
    // Scroll View Scene 3: Harmful Pollutants
    // Text equivalent to kg gases
    // Beakers exhaust fumes
    UILabel *pollutantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*2.1, 0, scrollView.frame.size.width*.8, scrollView.frame.size.height*.2)];
    pollutantsLabel.textAlignment = UITextAlignmentCenter;
    pollutantsLabel.textColor = [UIColor whiteColor];
    [pollutantsLabel setText:@"POLLUTANTS"];
    pollutantsLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:pollutantsLabel];  
    
    [self.view addSubview:scrollView];
    
    self.pollutantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*2.1, height*0.2, scrollView.frame.size.width*.8, scrollView.frame.size.height*.4)];
    self.pollutantsLabel.textAlignment = UITextAlignmentCenter;
    self.pollutantsLabel.textColor = [UIColor whiteColor];
    self.pollutantsLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:self.pollutantsLabel];
    
    // Add Page Control
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width*.4, self.view.frame.size.height*.9, self.view.frame.size.width*.2, self.view.frame.size.height*.1)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    
    // Set target action for paging control scrolling
    [self.pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Update the page when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
}

// This is to stop flashing in the scroll view
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)calculateButtonPushed:(id)sender {
    
    if(self.scrollView==nil)
    {
        // Set up calculator output view
        [self loadScrollView];
    }
    
    self.scrollView.hidden = NO;
    
    // Change values of labels in scroll view
    float concreteValue = [self.concreteQuantity floatValue];
    float cementValue = [self.cementQuantity floatValue];
    float ggbsValue = [self.ggbsQuantity floatValue];
    
    // Update CO2 part of output scroll view
    float co2saved = co2Coefficient * concreteValue * cementValue * ggbsValue;
    int carsOffTheRoad = roundf(carCoefficent * concreteValue * cementValue * ggbsValue);
    int treesSaved = roundf(treesCoefficent * concreteValue * cementValue * ggbsValue);
    self.co2SavedLabel.numberOfLines = 0;
    self.co2SavedLabel.text = [NSString stringWithFormat:@"CO2 Saved: %.1f Tonnes\nCars Off The Road: %i\nTrees Saved: %i", co2saved, carsOffTheRoad, treesSaved];
    
    // Update Energy part of output scroll view
    int energySavings =  roundf(energySaved * concreteValue * cementValue * ggbsValue);
    int homesInOneYear = roundf(averageHomes * concreteValue * cementValue * ggbsValue);
    self.energyLabel.numberOfLines = 0;
    self.energyLabel.text = [NSString stringWithFormat:@"Energy Saved: %i MJ\nAverage Homes in One Year: %i", energySavings, homesInOneYear];
    
    // Update Pollutants part of output scroll view
    int so2Savings =  roundf(so2Saved * concreteValue * cementValue * ggbsValue);
    int noxSavings =  roundf(noxSaved * concreteValue * cementValue * ggbsValue);
    int coSavings =  roundf(coSaved * concreteValue * cementValue * ggbsValue);
    int pm10Savings =  roundf(pm10Saved * concreteValue * cementValue * ggbsValue);
    self.pollutantsLabel.numberOfLines = 0;
    self.pollutantsLabel.text = [NSString stringWithFormat:@"SO2 Saved: %i kg\nNOx Saved: %i kg\nCO Saved: %i kg\nPM10 Saved: %i kg", so2Savings, noxSavings, coSavings, pm10Savings];
    
    // Set parameters for animations in scroll view
}


@end
