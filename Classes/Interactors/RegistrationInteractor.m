//
// RegistrationInteractor.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "RegistrationInteractor.h"

@implementation RegistrationInteractor

@synthesize dataManager;

- (instancetype)initWithDataManager:(RegistrationManager *)dataManagerObject
{
    if ((self = [super init]))
    {
        self.dataManager = dataManagerObject;
        self.dataManager.delegate = self;
    }
    
    return self;
}


- (BOOL) registerUser:(NSString *) strPhone;
{
    [self.dataManager registerUser:strPhone];
    
    return YES;
}


-(void)SuccessCallback:(id)data
             operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Got Registration Data in Interactor...");
        [self.delegate registerUserComplete:data];
    }
}

-(void)FailureCallback:(NSString *)errorDescription
             operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Error getting Registration Data in Interactor...");
        [self.delegate registerUserFailed:errorDescription];
    }
}

@end
