//
// MMTODOInteractor.m
//
// Copyright (c) 2014. All rights reserved.
//


#import "RegistrationManager.h"


@implementation RegistrationManager

@synthesize delegate;

- (BOOL) registerUser:(NSString *) strPhone
{
    WSService *service = [WSService sharedWSServiceInstance];
    service.delegate = self;
    
    [service getTestRESTCalls];
    
    return YES;
}

#pragma mark - WSService Delegate methods

-(void)wsServiceSuccessCallback:(WSService *)service
                     returnData:(id)data
                      operation:(NSString *)operation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSMutableArray *dataItems =  (NSMutableArray *)data;
        
        //Test JSON service call
        NSLog(@"Got Registration Data in Manager...");
        [self.delegate SuccessCallback:dataItems operation:operation];
    }
}

-(void)wsServiceFailureCallback:(WSService *)service
                    returnError:(NSString *)errorDescription
                      operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Error Getting Registration Data in Manager...");
        //Test JSON service call
        [self.delegate FailureCallback:errorDescription operation:operation];
    }
}


@end
