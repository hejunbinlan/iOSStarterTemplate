//
// RegistrationPresenter.m
//
// Copyright (c) 2014. All rights reserved.
//


#import "RegistrationPresenter.h"


@implementation RegistrationPresenter

- (BOOL) registerUser:(NSString *) strPhone;
{
    [self.regInteractor registerUser:strPhone];
    return YES;
}

#pragma mark - Registration Interactor Output

-(void)registerUserComplete: (id) registrationData
{
    NSLog(@"Registration is a success!!!!");
    [self.delegate registerUserComplete:registrationData];
}

-(void)registerUserFailed: (NSString *)error
{
    NSLog(@"Registration is a failure!!!!");
    [self.delegate registerUserFailed:error];
}

@end
