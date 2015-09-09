
//
//
// Copyright (c) 2014. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import "LeftPanelViewController.h"
#import "AuthorPresenter.h"
#import "AuthorDetailsViewController.h"
#import <iAd/iAd.h>


@protocol HomeViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end

@interface HomeViewController : UIViewController<LeftPanelViewControllerDelegate, ADBannerViewDelegate, AuthorPresentorDelegate, UITableViewDataSource, UITableViewDelegate, AuthorDetailsControllerDelegate>
{
    CGFloat viewHeight;
    
    IBOutlet UIImageView *imageBackground;
    IBOutlet ADBannerView *adBannerView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIButton *refresh;
    
    NSMutableArray *authorList;
    
    AuthorPresenter *authPresenter;
    
    AuthorDetailsViewController *authorDetailsController;
    
    IBOutlet UITableView *authorTableView;
}

@property (nonatomic, assign) id<HomeViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIButton *leftSettingsButton;
@property (nonatomic, retain) IBOutlet ADBannerView *adBannerView;


@property (nonatomic, retain) AuthorPresenter *authPresenter;

@end
