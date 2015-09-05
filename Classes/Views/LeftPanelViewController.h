//
//  LeftViewController.h
//
// Copyright (c) 2014. All rights reserved.
//


@protocol LeftPanelViewControllerDelegate <NSObject>

@required
- (void)settingItemSelected:(long)selOption;

@end



@interface LeftPanelViewController : UIViewController
{
      UITableView *leftNavTableView;
}

@property (nonatomic, assign) id<LeftPanelViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableView *leftNavTableView;

@end