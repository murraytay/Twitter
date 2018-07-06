//
//  DetailsViewController.h
//  twitter
//
//  Created by Taylor Murray on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@protocol DetailsViewControllerDelegate

-(void)didModifyTweet:(Tweet *)tweet;
@end

@interface DetailsViewController : UIViewController
@property (strong,nonatomic)Tweet *tweet;
@property (weak,nonatomic) id<DetailsViewControllerDelegate> delegate;
@end
