//
// CountryListInteractor.h
//
// Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryListManager.h"



@interface CountryListInteractor : NSObject
{
    CountryListManager *dataManager;
}

@property (nonatomic, retain)   CountryListManager *dataManager;

- (instancetype)initWithDataManager:(CountryListManager *)dataManagerObject;
- (NSArray *) getCountryList;
- (NSDictionary *) getCountryData;

@end
