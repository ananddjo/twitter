//
//  TweetVC.h
//  twitter
//
//  Created by Anand Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetVC : UIViewController

@property (strong, nonatomic) Tweet *tweetDetail;

- (id) initWithTweet:(Tweet *) tweetObj;

@end
