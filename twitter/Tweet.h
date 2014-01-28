//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *statusID;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSString *screenName;
@property (nonatomic, strong, readonly) NSString *createdTime;
@property (nonatomic, strong, readonly) UIImage *imgAuthor;
@property (nonatomic, strong, readonly) NSNumber *retweetNum;
@property (nonatomic, strong, readonly) NSNumber *favoriteNum;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
