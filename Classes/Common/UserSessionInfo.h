//
//  UserSessionInfo.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "viperTestDependencies.h"

//This is a Singleton class that is cached as long as the app is operating.
//Logon info is stored here and is used throught the app
@interface UserSessionInfo : NSObject
{
	NSString *userIdentifierNumber;
    NSString *userPhoneNumber;
    NSString *devicePushID;
    NSString *userCountryCode;
    NSString *userCountry;
    NSString *userPhoneNumberWithNoCC;
    
    NSString *databasePath;
    
    NSString *authToken;
    NSString *userId;
    viperTestDependencies *dependencies;
}

@property (nonatomic, copy) NSString *userIdentifierNumber;
@property (nonatomic, copy) NSString *userPhoneNumber;
@property (nonatomic, copy) NSString *devicePushID;
@property (nonatomic, copy) NSString *userCountryCode;
@property (nonatomic, copy) NSString *userCountry;
@property (nonatomic, copy) NSString *userPhoneNumberWithNoCC;
@property (nonatomic, copy) NSString *databasePath;

@property (nonatomic, copy) NSString *authToken;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) viperTestDependencies *dependencies;

+ (UserSessionInfo *)sharedUser;

@end
