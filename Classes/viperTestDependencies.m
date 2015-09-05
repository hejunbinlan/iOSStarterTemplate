//
// viperTestDependencies.m
//
// Copyright (c) 2014. All rights reserved.
//


#import "viperTestDependencies.h"

#import "RegistrationManager.h"
#import "RegistrationInteractor.h"

#import "CountryListInteractor.h"
#import "CountryListManager.h"

#import "AuthorInteractor.h"
#import "AuthorManager.h"

@implementation viperTestDependencies

@synthesize regPresenter, countryListPresenter, authorPresenter;

- (id)init
{
    if ((self = [super init]))
    {
        [self configureDependencies];
    }
    
    return self;
}

- (void)configureDependencies
{
    // Registration Modules Classes
    RegistrationPresenter *regPresenterObject = [[RegistrationPresenter alloc] init];
    RegistrationManager *regDataManager = [[RegistrationManager alloc] init];
    RegistrationInteractor *regInteractor = [[RegistrationInteractor alloc]    initWithDataManager:regDataManager];
    regInteractor.delegate = regPresenterObject;
    
    regPresenterObject.regInteractor = regInteractor;
    self.regPresenter = regPresenterObject;
    
    
    CountryListManager *countryListManager = [[CountryListManager alloc] init];
    CountryListInteractor *countryCodeInteractorObject = [[CountryListInteractor alloc] initWithDataManager:countryListManager];
    CountryListPresenter *countryListPresenterObject = [[CountryListPresenter alloc] init];
    countryListPresenterObject.countryListInteractor = countryCodeInteractorObject;
    self.countryListPresenter = countryListPresenterObject;
    
    
    AuthorPresenter *authPresenterObject = [[AuthorPresenter alloc] init];
    AuthorManager *authDataManager = [[AuthorManager alloc] init];
    AuthorInteractor *authInteractor = [[AuthorInteractor alloc] initWithDataManager:authDataManager];
    authInteractor.delegate = authPresenterObject;
    
    authPresenterObject.authInteractor = authInteractor;
    self.authorPresenter = authPresenterObject;
}

@end
