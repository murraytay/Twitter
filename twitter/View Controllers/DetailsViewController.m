//
//  DetailsViewController.m
//  twitter
//
//  Created by Taylor Murray on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import <UIKit+AFNetworking.h>
#import "APIManager.h"
#import "SelectedUserViewController.h"
#import "replyViewController.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewteetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) UIViewController *timelineViewControllerthing;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapRetweet:(UIButton *)sender {
    if(self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweetinh tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unrewteeted the following Tweet: %@", tweet.text);
                [self.delegate didModifyTweet:self.tweet];
            }
        }];
    } else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self.delegate didModifyTweet:self.tweet];
            }
        }];
    }
    [self setUI];
}
- (IBAction)didTapLike:(UIButton *)sender {
    if(self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [self.delegate didModifyTweet:self.tweet];
            }
        }];
    } else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self.delegate didModifyTweet:self.tweet];
            }
        }];
        
    }
    
    [self setUI];
    
}

-(void)setUI{
    
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profileURLString];
    
    [self.profileImage setImageWithURL:profilePicURL];
    
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingFormat:@"%@", self.tweet.user.screenName];
    self.tweetTextLabel.text = self.tweet.text;
    self.timeLabel.text = self.tweet.createdAtString;
    self.rewteetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if(self.tweet.favorited){
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"]
                        forState:UIControlStateNormal];
    } else{
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon.png"]
                        forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if([segue.identifier isEqualToString:@"reply-segue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        replyViewController *replyviewController = (replyViewController*)navigationController.topViewController;
        replyviewController.replyingToUser = self.tweet.user;
        replyviewController.delegate = self.timelineViewControllerthing;
    } else{
        // Pass the selected object to the new view controller.
        SelectedUserViewController *selectedViewController = [segue destinationViewController];
        selectedViewController.userMe = self.tweet.user;
        
    }
    
}


@end
