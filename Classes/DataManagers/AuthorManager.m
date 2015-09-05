//
// AuthorManager.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "AuthorManager.h"


@implementation AuthorManager

@synthesize delegate;

- (BOOL) getAllAuthors
{
    WSService *service = [WSService sharedWSServiceInstance];
    service.delegate = self;
    
    [service getTestRESTCalls];
    
    return YES;
}


- (BOOL) getAuthorDetailsGiven:(NSString *) authorId
{
    WSService *service = [WSService sharedWSServiceInstance];
    service.delegate = self;
    
    [service getTestRESTCallsForSingleRecord];
    
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
        
        NSMutableArray *arrAuthors = [[NSMutableArray alloc]init];
        
        for (NSDictionary *item in dataItems)
        {
            Author *auth = [[Author alloc] init];
            
            auth.title = item[@"title"];
            auth.body = item[@"body"];
            
            [arrAuthors addObject:auth];
        }
        
        //Test JSON service call
        NSLog(@"Got Authors Data in Manager...");
        [self.delegate SuccessCallback:arrAuthors operation:operation];
    }
    else if ([operation isEqualToString:@"get-test-single-data"])
    {
        NSMutableDictionary *dataItem =  (NSMutableDictionary *)data;
        
        Author *auth = [[Author alloc] init];
        
        auth.title = dataItem[@"title"];
        auth.body = dataItem[@"body"];
        
        NSLog(@"Got Author Data in Manager...");
        [self.delegate SuccessCallback:auth operation:operation];
    }
}

-(void)wsServiceFailureCallback:(WSService *)service
                    returnError:(NSString *)errorDescription
                      operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Error Getting Author Data in Manager...");
        //Test JSON service call
        [self.delegate FailureCallback:errorDescription operation:operation];
    }
    else if ([operation isEqualToString:@"get-test-single-data"])
    {
        NSLog(@"Error Getting Author Data in Manager...");
        [self.delegate FailureCallback:errorDescription operation:operation];
    }
}


@end
