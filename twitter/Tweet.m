//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)statusID {
    return [self.data  objectForKey:@"id_str"];
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)authorName {
    return [[self.data  objectForKey:@"user"]  objectForKey:@"name"];;
}

- (NSString *)screenName {
    NSMutableString *screenName = [[NSMutableString alloc]init];
    [screenName appendString:@"@"];
    [screenName appendString:[[self.data  objectForKey:@"user"]  objectForKey:@"screen_name"]];
    return screenName;
}

- (UIImage *) imgAuthor {
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[self.data  objectForKey:@"user"]  objectForKey:@"profile_image_url"]]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    return image;
}

- (NSString *)createdTime {
    NSDateFormatter *dateFromTwitter = [[NSDateFormatter alloc] init];
    [dateFromTwitter setDateFormat:@"EEE MMM dd HH:mm:ss '+0000' yyyy"];
    [dateFromTwitter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSString *dateString = [self.data objectForKey:@"created_at"];
    NSDate *tweetedDate = [dateFromTwitter dateFromString:dateString];
    
    NSDateFormatter *dateFromApp = [[NSDateFormatter alloc] init];
    [dateFromApp setDateFormat:@"MM/dd/yy, hh:mm a"];
    [dateFromApp setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    return [dateFromApp stringFromDate:tweetedDate];

}

- (NSNumber *)retweetNum {
    NSNumber *retweetNum = [self.data  objectForKey:@"retweet_count"];
    return retweetNum;
}

- (NSNumber *)favoriteNum {
    NSNumber *favoriteNum = [self.data  objectForKey:@"favorite_count"];
    return favoriteNum;
}


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
