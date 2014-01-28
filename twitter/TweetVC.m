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
    self.labelAuthorName.text = self.tweetDetail.authorName;
    self.labelScreenName.text = self.tweetDetail.screenName;
    self.profilePic.image = self.tweetDetail.imgAuthor;
    self.labelTweet.text = self.tweetDetail.text;
    self.labelDate.text = self.tweetDetail.createdTime;
    
    NSMutableString *retweetStr = [[NSMutableString alloc]init];
    [retweetStr appendString:[NSString stringWithFormat:@"%d",[self.tweetDetail.retweetNum intValue]]];
    self.retweet.text = retweetStr;
    
    NSMutableString *favoritesStr = [[NSMutableString alloc]init];
    [favoritesStr appendString:[NSString stringWithFormat:@"%d",[self.tweetDetail.favoriteNum intValue]]];
    self.favorites.text = favoritesStr;
    
}
- (IBAction)onReplyTweet:(id)sender {
    TweetComposeVC *addTweetComposeVC = [[TweetComposeVC alloc] initWithReplyTweet:self.tweetDetail.screenName replyStatusID:self.tweetDetail.statusID];
    [self.navigationController pushViewController:addTweetComposeVC animated:YES];
    
}
- (IBAction)onRetweet:(id)sender {
    
    NSString *statusID = self.tweetDetail.statusID;
    [[TwitterClient instance] doRetweet:statusID success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Status Retweeted!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not retweet!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}
- (IBAction)onFavorite:(id)sender {
    
    NSString *statusID = self.tweetDetail.statusID;
    [[TwitterClient instance] makeFavorite:statusID success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Marked as favorite!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your tweet was not favorited!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end
