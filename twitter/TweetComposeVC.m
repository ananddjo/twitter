//
//  TweetComposeVC.m
//  twitter
//
//  Created by Anand Joshi on 1/27/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetComposeVC.h"
#import "User.h"

@interface TweetComposeVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelScreenName;
@property (weak, nonatomic) IBOutlet UITextView *txtTweet;

@property (assign, nonatomic) NSString *replyStatusID;
@property (retain, nonatomic) NSString *screenName;

- (IBAction)onTap:(id)sender;

@end

@implementation TweetComposeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithReplyTweet:(NSString *)screenName replyStatusID:(NSString *) statusID
{
    if (self) {
        self.replyStatusID = statusID;
        self.screenName = screenName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Cancel";
    self.navigationItem.title = @"";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.txtTweet.delegate = self;
    
    if (self.replyStatusID) {
        self.txtTweet.text = [NSString stringWithFormat:@"%@ ",self.screenName];
    }
    [self updateViewWithUserInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateViewWithUserInformation
{
    User *userContext = [User currentUser];
    self.labelName.text = [userContext  objectForKey:@"name"];
    NSMutableString *screenName = [[NSMutableString alloc]init];
    [screenName appendString:@"@"];
    [screenName appendString:[userContext objectForKey:@"screen_name"]];
    self.labelScreenName.text = screenName;
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[userContext  objectForKey:@"profile_image_url"]]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    self.imgProfilePic.image = image;
}

- (void) onTweetButton {
    
    NSString *replyStatusId = @"";
    if (self.replyStatusID) {
        replyStatusId = self.replyStatusID;
    }
    
    [[TwitterClient instance] doTweet:self.txtTweet.text inReplyToStatusId:replyStatusId success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Status Updated!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not tweet!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];

    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (!self.replyStatusID) {
        self.txtTweet.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.txtTweet.text.length == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.txtTweet.text = @"What's Happening ?";
    } else {
        if (self.replyStatusID && (self.txtTweet.text.length == self.screenName.length)){
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.txtTweet.text.length == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
       [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
