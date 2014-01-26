//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Modified by Anand Joshi
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelAuthorName;
@property (strong, nonatomic) IBOutlet UILabel *labelAuthorID;
@property (strong, nonatomic) IBOutlet UILabel *labelTweet;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@end
