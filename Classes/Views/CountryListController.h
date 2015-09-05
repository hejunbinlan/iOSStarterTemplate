//
//  CountryListController.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CountryListPresenter.h"
@protocol CountryListControllerDelegate <NSObject>

@required
- (void)selectCountry: (NSString *)countryCode;

@end

@interface CountryListController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *ccTable;
	
    NSDictionary *countryIndexMap;
    NSArray *ccList;
    NSArray *ccIndexList;
    
    NSString *strSelectedCountry;
}

@property (nonatomic, assign) id<CountryListControllerDelegate> delegate;
@property (nonatomic, retain) UITableView *ccTable;
@property (nonatomic, retain) NSString *strSelectedCountry;

@end
