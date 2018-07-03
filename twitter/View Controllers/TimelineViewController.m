//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import <UIKit+AFNetworking.h>
#import "ComposeViewController.h"
@interface TimelineViewController () <UITableViewDelegate,UITableViewDataSource,ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic,strong) NSArray *arrayOfTweets;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timelineTableView.delegate = self;
    self.timelineTableView.dataSource = self;
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchTweets{
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            [self.timelineTableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"table view setup");
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.arrayOfTweets[indexPath.row];
    cell.postTextLabel.text = cell.tweet.text;
    cell.nameLabel.text = cell.tweet.user.name;
    cell.usernameLabel.text = cell.tweet.user.screenName;
    cell.dateLabel.text = cell.tweet.createdAtString;
    cell.retweetLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    cell.favLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
//    if(cell.tweet.favorited){
//        cell.favButton.im
//    }
    NSURL *profilePicURL = [NSURL URLWithString:cell.tweet.user.profileURLString];
    
    [cell.profilePictureImage setImageWithURL:profilePicURL];
    
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"we doing the row number");
    return self.arrayOfTweets.count;
}





 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     UINavigationController *navigationController = [segue destinationViewController];
     ComposeViewController *composeViewController = (ComposeViewController *)navigationController.topViewController;
     composeViewController.delegate = self;
 }
 




- (void)didTweet:(Tweet *)tweet {
    
}



@end
