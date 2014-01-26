//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Modified by Anand Joshi
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

@synthesize labelTweet = _labelTweet;
@synthesize labelAuthorName = _labelAuthorName;
@synthesize labelAuthorID = _labelAuthorID;
@synthesize imgProfile = _imgProfile;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.labelTweet = [UILabel alloc];
        self.labelAuthorName = [UILabel alloc];
        self.labelAuthorID = [UILabel alloc];
        self.imgProfile = [UIImageView alloc];
        //self.labelTweet = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        //self.labelTweet.textColor = [UIColor blueColor];
        //self.labelTweet.font = [UIFont fontWithName:@"Arial" size:12.0f];
        //[self addSubview:self.labelTweet];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
