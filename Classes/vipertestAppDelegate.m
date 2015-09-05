
//
// Copyright (c) 2014. All rights reserved.
//

#import "HomeViewController.h"
#import "vipertestAppDelegate.h"
#import "RegistrationViewController.h"
#import "UserSessionInfo.h"

@implementation vipertestAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //Register Push Notifications
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        // Let the device know we want to receive push notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    viperTestDependencies *dependenciesInfo = [[viperTestDependencies alloc] init];
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    userSession.dependencies = dependenciesInfo;
    
    [self performFirstStartActivities];
    
    NSString *aNibName = @"Registration";
    rootController = [[RegistrationViewController alloc] initWithNibName:aNibName bundle:nil];
    rootController.regPresenter = userSession.dependencies.regPresenter;
    
    // Handle on Terminated state, app launched because of APN
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [window setRootViewController:rootController];
    [window makeKeyAndVisible];
    
    return YES;
}

-(void)performFirstStartActivities
{
    NSLog(@"Performing Initial DB Copy...");
    
    // Create a string containing the full path to the sqlite.db inside the documents folder
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"viperlocaldbs.sqlite"];
    
    
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSString *appFirstStartOfVersionKey = [NSString stringWithFormat:@"first_start_%@", bundleVersion];
    NSNumber *alreadyStartedOnVersion = [[NSUserDefaults standardUserDefaults] objectForKey:appFirstStartOfVersionKey];
    
    // Get the path to the database in the application package or Bundle
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *pathOfDB = [resourcePath stringByAppendingPathComponent:@"viperlocaldb.sqlite"];
    
    NSError *err;
    
    if((!alreadyStartedOnVersion || [alreadyStartedOnVersion boolValue] == NO))
    {
        NSLog(@"Very First Time Launch...");
        
        //Do these only on first time launch
        
        //Pushing new DB
        NSLog(@"Pushing updated DB from Bundle to Documents folder...");
        
        // Check to see if the database file already exists
        bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        
        // if the DB exists in the file system, then delete the DB
        if (databaseAlreadyExists)
        {
            NSLog(@"Old DB deleted...");
            [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
        }
        
        // Copy the database from the package to the users filesystem
        [[NSFileManager defaultManager] copyItemAtPath:pathOfDB toPath:dbPath error:&err];
        
        NSLog(@"Database created.");
    }
    else
    {
        // Check to see if the database file already exists
        bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        
        // Push the DB the database if it doesn't yet exists in the file system
        if (!databaseAlreadyExists)
        {
            //We should never get here - But better safe than Sorry!
            
            // Copy the database from the package to the users filesystem
            [[NSFileManager defaultManager] copyItemAtPath:pathOfDB toPath:dbPath error:&err];
            
            NSLog(@"Database created");
        }
    }
    
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    
    if (err == nil)
    {
        userSession.databasePath = dbPath;
    }
    else
    {
        NSLog(@"Alert!!!  Could not move DB in the documents folder");
        userSession.databasePath = pathOfDB;
    }
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}

- (void)applicationDidEnterForeground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {

    
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    
    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    userSession.devicePushID = newToken;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    userSession.devicePushID = @"";
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Detect if APN is received on Background or Foreground state
    if (application.applicationState == UIApplicationStateInactive)
    {
        //Do something
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        //[rootController.mainVC.centerViewController showMyReviews];
    }
    else if (application.applicationState == UIApplicationStateActive)
    {
        //Do something
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
}

@end
