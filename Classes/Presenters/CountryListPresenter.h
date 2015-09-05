//
// RegistrationPresenter.h
//
// Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CountryListInteractor.h"
#import "CountryListPresenter.h"


@interface CountryListPresenter : NSObject

@property (nonatomic, strong) CountryListInteractor *countryListInteractor;

- (NSArray *) getCountryList;
- (NSDictionary *) getCountryData;

@end