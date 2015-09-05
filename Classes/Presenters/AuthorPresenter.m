//
// AuthorPresentor.m
//
// Copyright (c) 2014

#import "AuthorPresenter.h"


@implementation AuthorPresenter

- (BOOL) getAllAuthors;
{
    [self.authInteractor getAllAuthors];
    return YES;
}

- (BOOL) getAuthorDetailsGiven:(NSString *) authorId
{
    [self.authInteractor getAuthorDetailsGiven:authorId];
    return YES;
}

#pragma mark - Author Interactor Output

-(void)getAllAuthorsSuccess: (id) authorData
{
    NSLog(@"Getting Authors Data is a success!!!!");
    [self.delegate getAllAuthorsSuccess:authorData];
}

-(void)getAllAuthorsFailed: (NSString *)error
{
    NSLog(@"Getting Authors Data is a failure!!!!");
    [self.delegate getAllAuthorsFailed:error];
}

-(void)getAuthorDetailsSuccess: (id) authorData
{
    NSLog(@"Getting Author Details is a success!!!!");
    [self.delegate getAuthorDetailsSuccess:authorData];
}

-(void)getAuthorDetailsFailed: (NSString *)error
{
    NSLog(@"Getting Author Details is a failure!!!!");
    [self.delegate getAuthorDetailsFailed:error];
}


@end
