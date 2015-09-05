//
//  MainViewController.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface MainViewController : UIViewController<HomeViewControllerDelegate, UIGestureRecognizerDelegate>
{
    HomeViewController *centerViewController;
}

@property (nonatomic, retain) HomeViewController *centerViewController;
@property (nonatomic, strong) LeftPanelViewController *leftPanelViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end
