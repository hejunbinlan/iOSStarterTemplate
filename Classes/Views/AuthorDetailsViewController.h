// AuthorDetailsViewController.h
//
// Copyright (c) 2014. All rights reserved.

#import <UIKit/UIKit.h>
#import "AuthorPresenter.h"

@protocol AuthorDetailsControllerDelegate <NSObject>

@required
- (void)hideAuthorDetails;

@end

@interface AuthorDetailsViewController : UIViewController<AuthorPresentorDelegate>
{
    IBOutlet UILabel *dummyData;
    
    IBOutlet UIButton *btnSend;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    BOOL changesMade;
    float viewHeight;
    
    AuthorPresenter *authPresenter;
}

@property (nonatomic, assign) id<AuthorDetailsControllerDelegate> delegate;

- (void) fixViewHeightIssue;

- (void) f_load;

@end
