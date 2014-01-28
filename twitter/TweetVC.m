//
//  TweetVC.m
//  twitter
//
//  Created by Anand Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "TweetComposeVC.h"

@interface TweetVC ()

@property (weak, nonatomic) IBOutlet UILabel *labelTweet;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *labelScreenName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *retweet;
@property (weak, nonatomic) IBOutlet UILabel *favorites;
@end

@implementation TweetVC
@synthesize scrollView;

- (id)initWithTweet:(Tweet *)tweetObj
{
    self = [super init];
    if (self) {
        self.tweetDetail = tweetObj;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.title = @"Tweet";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    [self updateViewWithTweets];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTweetButton {
    [self.navigationController pushViewController:[[TweetComposeVC alloc] init] animated:YES];
}

- (void)updateViewWithTweets {
    self.labelAuthorName.text = [[self.tweetDetail.data  objectForKey:@"user"]  objectForKey:@"name"];
    NSMutableString *screenName = [[NSMutableString alloc]init];
    [screenName appendString:@"@"];
    [screenName appendString:[[self.tweetDetail.data  objectForKey:@"user"]  objectForKey:@"screen_name"]];
    self.labelScreenName.text = screenName;
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[self.tweetDetail.data  objectForKey:@"user"]  objectForKey:@"profile_image_url"]]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    self.profilePic.image = image;
    self.labelTweet.text = self.tweetDetail.text;
    
    NSDateFormatter *dateFromTwitter = [[NSDateFormatter alloc] init];
    [dateFromTwitter setDateFormat:@"EEE MMM dd HH:mm:ss '+0000' yyyy"];
    [dateFromTwitter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSString *dateString = [self.tweetDetail.data objectForKey:@"created_at"];
    NSDate *tweetedDate = [dateFromTwitter dateFromString:dateString];
    
    NSDateFormatter *dateFromApp = [[NSDateFormatter alloc] init];
    [dateFromApp setDateFormat:@"MM/dd/yy, hh:mm a"];
    [dateFromApp setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    self.labelDate.text = [dateFromApp stringFromDate:tweetedDate];
    
    NSMutableString *retweetStr = [[NSMutableString alloc]init];
    NSNumber *retweetNum = [self.tweetDetail.data  objectForKey:@"retweet_count"];
    [retweetStr appendString:[NSString stringWithFormat:@"%d",[retweetNum intValue]]];
    self.retweet.text = retweetStr;
    
    NSMutableString *favoritesStr = [[NSMutableString alloc]init];
    NSNumber *favoriteNum = [self.tweetDetail.data  objectForKey:@"favorite_count"];
    [favoritesStr appendString:[NSString stringWithFormat:@"%d",[favoriteNum intValue]]];
    self.favorites.text = favoritesStr;
    
}
- (IBAction)onReplyTweet:(id)sender {
    NSString *statusID = [self.tweetDetail.data  objectForKey:@"id_str"];
    TweetComposeVC *addTweetComposeVC = [[TweetComposeVC alloc] initWithReplyTweet:self.labelScreenName.text replyStatusID:statusID];
    [self.navigationController pushViewController:addTweetComposeVC animated:YES];
    
}
- (IBAction)onRetweet:(id)sender {
    
    NSString *statusID = [self.tweetDetail.data  objectForKey:@"id_str"];
    [[TwitterClient instance] doRetweet:statusID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Status Retweeted!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not retweet!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}
- (IBAction)onFavorite:(id)sender {
    
    NSString *statusID = [self.tweetDetail.data  objectForKey:@"id_str"];
    [[TwitterClient instance] makeFavorite:statusID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Marked as favorite!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your tweet was not favorited!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end
