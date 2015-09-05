//
// viperTestDependencies.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RegistrationPresenter.h"
#import "CountryListPresenter.h"
#import "AuthorPresenter.h"

@interface viperTestDependencies : NSObject
{
    RegistrationPresenter *regPresenter;
    CountryListPresenter *countryListPresenter;
    AuthorPresenter *authorPresenter;
}

@property (nonatomic, strong) RegistrationPresenter *regPresenter;
@property (nonatomic, strong) CountryListPresenter *countryListPresenter;
@property (nonatomic, strong) AuthorPresenter *authorPresenter;


@end
