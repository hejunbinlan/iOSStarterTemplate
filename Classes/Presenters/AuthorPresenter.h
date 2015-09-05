//
// AuthorPresenter.h
//
// Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthorInteractor.h"


@protocol AuthorPresentorDelegate <NSObject>

@optional

-(void)getAllAuthorsSuccess: (id) authorData;
-(void)getAllAuthorsFailed: (NSString *)error;
-(void)getAuthorDetailsSuccess: (id) authorData;
-(void)getAuthorDetailsFailed: (NSString *)error;

@end

@interface AuthorPresenter : NSObject <AuthorInteractorDelegate>

@property (nonatomic, weak) id <AuthorPresentorDelegate> delegate;
@property (nonatomic, strong) AuthorInteractor *authInteractor;


- (BOOL) getAllAuthors;

- (BOOL) getAuthorDetailsGiven:(NSString *) authorId;

@end
