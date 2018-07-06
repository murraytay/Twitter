//
//  ComposeViewController.h
//  twitter
//
//  Created by Taylor Murray on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *charactersLeftLabel;
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)tweetAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;
@property (strong,nonatomic) NSURL *profilepicURL;

@end


