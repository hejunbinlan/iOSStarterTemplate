//
// AuthorInteractor.h
//
// Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorManager.h"
#import "ManagerBase.h"

@protocol AuthorInteractorDelegate <NSObject>

-(void)getAllAuthorsSuccess: (id) authorData;
-(void)getAllAuthorsFailed: (NSString *)error;
-(void)getAuthorDetailsSuccess: (id) authorData;
-(void)getAuthorDetailsFailed: (NSString *)error;

@end


@interface AuthorInteractor : NSObject<ManagerDelegate>
{
    AuthorManager *dataManager;
}

@property (nonatomic, weak) id <AuthorInteractorDelegate> delegate;
@property (nonatomic, retain)   AuthorManager *dataManager;

- (instancetype)initWithDataManager:(AuthorManager *)dataManagerObject;

- (BOOL) getAllAuthors;

- (BOOL) getAuthorDetailsGiven:(NSString *) authorId;

@end
