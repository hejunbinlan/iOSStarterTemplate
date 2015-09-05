//
// CountryListPresenter.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "CountryListPresenter.h"


@implementation CountryListPresenter

- (NSArray *) getCountryList;
{
    return [self.countryListInteractor getCountryList];
}

- (NSDictionary *) getCountryData
{
    return [self.countryListInteractor getCountryData];
}

@end
