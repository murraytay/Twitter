//
//  TweetCell.h
//  twitter
//
//  Created by Taylor Murray on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@property (strong, nonatomic) Tweet *tweet;
@end
