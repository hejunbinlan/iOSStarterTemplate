//
// RegistrationPresenter.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "RegistrationInteractor.h"


@protocol RegistrationPresentorDelegate <NSObject>

-(void)registerUserComplete: (id) registrationData;
-(void)registerUserFailed: (NSString *)error;

@end

@interface RegistrationPresenter : NSObject <RegistrationInteractorDelegate>

@property (nonatomic, weak) id <RegistrationPresentorDelegate> delegate;
@property (nonatomic, strong) RegistrationInteractor *regInteractor;


- (BOOL) registerUser:(NSString *) strPhone;

@end
