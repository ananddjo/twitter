//
//  TweetComposeVC.h
//  twitter
//
//  Created by Anand Joshi on 1/27/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetComposeVC : UIViewController <UITextViewDelegate>

- (id) initWithReplyTweet:(NSString *)sceenName replyStatusID:(NSString *) statusID;

@end
