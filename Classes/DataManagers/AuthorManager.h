//
// AuthorManager.h
//
// Copyright (c) 2014. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WSService.h"
#import "ManagerBase.h"
#import "Author.h"

@interface AuthorManager : NSObject<WSServiceDelegate>
{
    
}

@property (nonatomic, weak) id <ManagerDelegate> delegate;
- (BOOL) getAllAuthors;

- (BOOL) getAuthorDetailsGiven:(NSString *) authorId;


@end
