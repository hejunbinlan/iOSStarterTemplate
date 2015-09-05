//
//  RegistrationViewController
//
// Copyright (c) 2014. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "RegistrationPresenter.h"
#import "CountryListController.h"

@interface RegistrationViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, RegistrationPresentorDelegate, CountryListControllerDelegate>
{
    UIActivityIndicatorView *activityIndicator;
    UITextField *phoneNumber;
    UIButton *getStarted;
    UILabel *messageLabelRegistration;
    UILabel *messageLabel;
    UIButton *buttonTryAgain;
    UIButton *questions;
    
    NSString *appFirstStartOfVersionKey;
    
	IBOutlet UIImageView *backgroungImage;
    
    RegistrationPresenter *regPresenter;
    CountryListController *countryController;
    MainViewController *mainVC;
    UINavigationController *ilNavController;
    
    BOOL shownMainView;
}

- (IBAction) tryAgain : (id)sender;
- (IBAction) getStarted : (id)sender;
- (IBAction) gotQuestions : (id)sender;

- (void) showMainView;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *messageLabelRegistration;

@property (nonatomic, retain) IBOutlet UITextField *phoneNumber;
@property (nonatomic, retain) IBOutlet UIButton *getStarted;

@property (nonatomic, retain) IBOutlet UIButton *buttonTryAgain;
@property (nonatomic, retain) IBOutlet UIButton *questions;

@property (nonatomic, retain) MainViewController *mainVC;

@property (nonatomic, retain) RegistrationPresenter *regPresenter;

@end
