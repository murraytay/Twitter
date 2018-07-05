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
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface TimelineViewController () <UITableViewDelegate,UITableViewDataSource,ComposeViewControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic,strong) NSArray *arrayOfTweets;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
//@property (nonatomic,assign) BOOL isMoreDataLoading;
@end

@implementation TimelineViewController
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(!self.isMoreDataLoading){
//        // Calculate the position of one screen length before the bottom of the results
//        int scrollViewContentHeight = self.timelineTableView.contentSize.height;
//        int scrollOffsetThreshold = scrollViewContentHeight - self.timelineTableView.bounds.size.height;
//
//        // When the user has scrolled past the threshold, start requesting
//        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.timelineTableView.isDragging) {
//            self.isMoreDataLoading = true;
//            [self loadMoreData];
//            // ... Code to load more results ...
//        }
//    }
//}

- (IBAction)logoutAction:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timelineTableView.delegate = self;
    self.timelineTableView.dataSource = self;
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];

}

//-(void)loadMoreData{
//    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
//        if (tweets) {
//            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            self.arrayOfTweets = tweets;
//
//            self.isMoreDataLoading = false;
//            [self.timelineTableView reloadData];
//        } else {
//            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
//        }
//    }];
//
//}

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
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    [cell setTweet:tweet];
//    cell.postTextLabel.text = cell.tweet.text;
//    cell.nameLabel.text = cell.tweet.user.name;
//    cell.usernameLabel.text = cell.tweet.user.screenName;
//    cell.dateLabel.text = cell.tweet.createdAtString;
//    cell.retweetLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
//    cell.favLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
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
    NSArray *newTweetArray = [self.arrayOfTweets arrayByAddingObject:tweet];
    self.arrayOfTweets = newTweetArray;
    [self fetchTweets];
    
}



@end
