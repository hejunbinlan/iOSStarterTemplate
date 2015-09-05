//
//  UserSessionInfo.h
//
// Copyright (c) 2014. All rights reserved.
//


#import "UserSessionInfo.h"

static UserSessionInfo *sharedUser = nil;

@implementation UserSessionInfo

@synthesize userIdentifierNumber, userPhoneNumber, devicePushID, userCountryCode, userPhoneNumberWithNoCC, userCountry,
databasePath, authToken, userId, dependencies;


#pragma mark -
#pragma mark Singleton Methods
+ (UserSessionInfo *)sharedUser {
	
    if(sharedUser == nil)
    {
		sharedUser = [[super allocWithZone:NULL] init];
	}
	return sharedUser;
}


- (void) dealloc {

}

- (id) init {
    if ( self = [super init] ) {
		// Set defaults
        userCountry = @"";
        userIdentifierNumber = @"";
        userPhoneNumber = @"";
        devicePushID = @"";
        userCountryCode = @"";
        userPhoneNumberWithNoCC = @"";
        authToken = @"";
        userId = @"";
    }
    return self;
}


@end
