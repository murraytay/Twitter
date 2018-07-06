//
//  replyViewController.h
//  twitter
//
//  Created by Taylor Murray on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@protocol replyViewControllerDelegate

- (void)didReply:(Tweet *)tweet;

@end
@interface replyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *replyAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelAction;
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;
@property (weak, nonatomic) id<replyViewControllerDelegate> delegate;
@property (strong, nonatomic) User *replyingToUser;
@end
