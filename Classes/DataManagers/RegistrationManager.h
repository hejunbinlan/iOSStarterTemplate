//
// RegistrationManager.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WSService.h"
#import "ManagerBase.h"


@interface RegistrationManager : NSObject<WSServiceDelegate>
{
    
}

@property (nonatomic, weak) id <ManagerDelegate> delegate;
- (BOOL) registerUser:(NSString *) strPhone;


@end
