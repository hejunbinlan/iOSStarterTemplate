//
// RegistrationInteractor.h
//
// Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationManager.h"
#import "ManagerBase.h"

@protocol RegistrationInteractorDelegate <NSObject>

-(void)registerUserComplete: (id) registrationData;
-(void)registerUserFailed: (NSString *)error;

@end


@interface RegistrationInteractor : NSObject<ManagerDelegate>
{
    RegistrationManager *dataManager;
}

@property (nonatomic, weak) id <RegistrationInteractorDelegate> delegate;
@property (nonatomic, retain)   RegistrationManager *dataManager;

- (instancetype)initWithDataManager:(RegistrationManager *)dataManagerObject;
- (BOOL) registerUser:(NSString *) strPhone;

@end
