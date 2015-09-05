//
// CountryListInteractor.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "CountryListInteractor.h"

@implementation CountryListInteractor

@synthesize dataManager;

- (instancetype)initWithDataManager:(CountryListManager *)dataManagerObject
{
    if ((self = [super init]))
    {
        self.dataManager = dataManagerObject;
    }
    
    return self;
}


- (NSArray *) getCountryList;
{
    NSArray *countryList = [self.dataManager getCountryList];
    
    return countryList;
}

- (NSDictionary *) getCountryData
{
    return [self.dataManager getCountryData];
}

@end
