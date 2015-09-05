//
// AuthorInteractor.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "AuthorInteractor.h"

@implementation AuthorInteractor

@synthesize dataManager;

- (instancetype)initWithDataManager:(AuthorManager *)dataManagerObject
{
    if ((self = [super init]))
    {
        self.dataManager = dataManagerObject;
        self.dataManager.delegate = self;
    }
    
    return self;
}


- (BOOL) getAllAuthors
{
    [self.dataManager getAllAuthors];
    return YES;
}

- (BOOL) getAuthorDetailsGiven:(NSString *) authorId
{
    [self.dataManager getAuthorDetailsGiven:authorId];
    return YES;
}

-(void)SuccessCallback:(id)data
             operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Got Author Data in Interactor...");
        [self.delegate getAllAuthorsSuccess:data];
    }
    else if ([operation isEqualToString:@"get-test-single-data"])
    {
        NSLog(@"Got Author Details in Interactor...");
        [self.delegate getAuthorDetailsSuccess:data];
    }
}

-(void)FailureCallback:(NSString *)errorDescription
             operation:(NSString *)operation
{
    if ([operation isEqualToString:@"get-test-data-response"])
    {
        NSLog(@"Error getting Author Data in Interactor...");
        [self.delegate getAllAuthorsFailed:errorDescription];
    }
    else if ([operation isEqualToString:@"get-test-single-data"])
    {
        [self.delegate getAuthorDetailsFailed:errorDescription];
        NSLog(@"Error getting Author Data in Interactor...");
    }
}

@end
