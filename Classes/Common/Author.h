//
// Author.h
//
// Copyright (c) 2014. All rights reserved.

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, assign)   long authorId;
@property (nonatomic, assign)   long internalId;
@property (nonatomic, copy)     NSString*   title;
@property (nonatomic, copy)     NSString*   body;

@end
