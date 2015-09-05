//
//  RegistrationViewController.m
//
// Copyright (c) 2014. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "RegistrationViewController.h"
#import "UserSessionInfo.h"
#import "Utils.h"

#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2

#define CORNER_RADIUS 4

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60


@implementation RegistrationViewController

@synthesize activityIndicator, messageLabelRegistration, phoneNumber, getStarted, messageLabel,buttonTryAgain,
questions, mainVC, regPresenter;

#pragma mark -
#pragma mark View Did Load/Unload

-(void)viewDidLoad
{
    [phoneNumber addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    phoneNumber.delegate = self;
    
    shownMainView = NO;
    regPresenter.delegate = self;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (shownMainView == YES)
        return;
    
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    appFirstStartOfVersionKey = [NSString stringWithFormat:@"first_start_%@", bundleVersion];
    NSNumber *alreadyStartedOnVersion = [[NSUserDefaults standardUserDefaults] objectForKey:appFirstStartOfVersionKey];
    
    if((!alreadyStartedOnVersion || [alreadyStartedOnVersion boolValue] == NO))
    {
        [self performRegistrationForTheFirstTimeEver];
    }
    else
    {
        [self startRegistration];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //Our ensure we show the proper image on load based on orientation
        NSTimeInterval duration = 0.0;
        if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeTheViewToPortrait:YES andDuration:duration];
        }
        else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            //self.view = landscapeView;
            [self changeTheViewToPortrait:NO andDuration:duration];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {

    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height > 500)
        {
            //Hack to fix a UI bug
            
            [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,result.height)];
        }
    }
    
	[super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


#pragma mark -
#pragma mark View Management

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self changeTheViewToPortrait:YES andDuration:duration];
        }
        else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            //self.view = landscapeView;
            [self changeTheViewToPortrait:NO andDuration:duration];
        }
        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}



#pragma mark - Private methods

- (void) performRegistrationForTheFirstTimeEver
{
    [questions setHidden:NO];
    [messageLabel setHidden:YES];
    [activityIndicator setHidden:YES];
    [activityIndicator stopAnimating];
    [buttonTryAgain setHidden:YES];
}

- (void) startRegistration
{
    [questions setHidden:YES];
    [activityIndicator setHidden:NO];
    [activityIndicator startAnimating];
    [buttonTryAgain setHidden:YES];
    [messageLabel setHidden:YES];
    
    NSString *strPhone = [Utils getTrimmedString:phoneNumber.text];
    
    [self.regPresenter registerUser:strPhone];
}

- (void) showMessageOnError
{
    messageLabelRegistration.text = @"There was an issue during Registration. Please try again.";
    
    [questions setHidden:NO];
    [activityIndicator setHidden:YES];
    [activityIndicator stopAnimating];
    [buttonTryAgain setHidden:NO];
    [messageLabel setHidden:NO];
}

- (void) showMainView
{
    ilNavController = [[UINavigationController alloc] init];
    mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:Nil];
    
    [ilNavController pushViewController:mainVC animated:NO];
    
    [self.view addSubview:ilNavController.view];
    
    [self addChildViewController:ilNavController];
    [mainVC didMoveToParentViewController:self];
    
    shownMainView = YES;
}

- (void) changeTheViewToPortrait:(BOOL)portrait andDuration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];

    if(portrait)
    {
        UIImage *img = [UIImage imageNamed:@"Scenic-Portrait.png"];
        [backgroungImage setImage:img];
        
    }
    else
    {
        UIImage *img = [UIImage imageNamed:@"Scenic-Landscape.png"];
        [backgroungImage setImage:img];
        
    }
    
    [UIView commitAnimations];
}


#pragma mark - Button Handlers

- (IBAction) tryAgain : (id)sender
{
    messageLabelRegistration.text = @"Contacting Server. Trying again...";
    [self startRegistration];
}


- (IBAction) getStarted : (id)sender
{
    [phoneNumber resignFirstResponder];
    NSString *phoneNumberString = phoneNumber.text;
    
    [self startRegistration];    
}

- (IBAction) gotQuestions : (id)sender
{
    if (countryController == nil)
    {
        countryController = [[CountryListController alloc] initWithNibName:@"CountriesController" bundle:nil];
        countryController.delegate = self;
    }
    
    countryController.strSelectedCountry = @"";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //Create a Navigation controller
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:countryController];
        
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:navController animated:YES completion:^(void) {}];
    }
    else
    {
        countryController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:countryController animated:YES completion:^(void) {}];
    }
}


#pragma mark - CountryList Delegate methods

- (void)selectCountry: (NSString *)countryCode
{
    NSLog(@"Country = %@", countryCode);
    
    [self dismissViewControllerAnimated:YES completion:nil];    
}


#pragma mark - Registration Presentor Output

-(void)registerUserComplete: (id) registrationData
{
    NSLog(@"In the View! Registration is a success!!!!");
    [self showMainView];

}

-(void)registerUserFailed: (NSString *)error
{
    NSLog(@"In the View! Registration is a failure!!!!");
    [self showMessageOnError];
}


#pragma mark -
#pragma mark Delegates Methods and Events

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex)
    {
        case 0: //"No" pressed
            break;
        case 1: //"Yes" pressed
            [self startRegistration];
            break;
    }
}

-(void) textDidChange:(id)sender
{
    UITextField* phoneField = (UITextField *) sender;
    NSString *strPhone = phoneField.text;
    
    if ([strPhone length] == 0)
    {
        [phoneField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
