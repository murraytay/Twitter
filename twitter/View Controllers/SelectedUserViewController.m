//
//  SelectedUserViewController.m
//  twitter
//
//  Created by Taylor Murray on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "SelectedUserViewController.h"
#import <UIKit+AFNetworking.h>
#import "APIManager.h"
#import "TweetCell.h"
@interface SelectedUserViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (nonatomic,strong) NSArray *arrayTweets;
@end

@implementation SelectedUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
    if(self.userMe == nil){
        [[APIManager shared] getUser:^(User *user, NSError *error) {
            if(user){
                self.userMe = user;
            } else{
                NSLog(@"error in getting personal profile");
            }
        }];
    }
    
    [self setUI];
    [self fetchUserTweets];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUI{
    NSURL *backgroundURL = [NSURL URLWithString:self.userMe.bannerURLString];
    [self.backgroundImage setImageWithURL: backgroundURL];
    
    self.nameLabel.text = self.userMe.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.userMe.screenName];
    self.bioLabel.text = self.userMe.descriptionUser;
    self.followerCountLabel.text = [self.userMe.followersCount stringValue];
    self.followingCountLabel.text = [self.userMe.followingCount stringValue];
    
    NSURL *profileURL = [NSURL URLWithString:self.userMe.profileURLString];
    [self.profileImage setImageWithURL:profileURL];
    
    
}

-(void)fetchUserTweets{
    [[APIManager shared] userTimeline:self.userMe completion:^(NSArray *tweets, NSError *error) {
        if(tweets){
            self.arrayTweets = tweets;
            [self.profileTableView reloadData];
            NSLog(@"😎😎😎 Successfully loaded profile timeline");
        } else{
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.arrayTweets[indexPath.row];
    [cell setTweet:tweet];
    NSURL *profilePicURL = [NSURL URLWithString:cell.tweet.user.profileURLString];
    
    [cell.profilePictureImage setImageWithURL:profilePicURL];
    
    NSURL *mediaURL = [NSURL URLWithString:tweet.mediaArray[0][@"media_url_https"]];
    
    [cell.mediaImage setImageWithURL:mediaURL];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayTweets.count;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
