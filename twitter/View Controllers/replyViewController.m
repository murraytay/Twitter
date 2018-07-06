//
//  replyViewController.m
//  twitter
//
//  Created by Taylor Murray on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "replyViewController.h"
#import "APIManager.h"
@interface replyViewController ()

@end

@implementation replyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.replyTextView.text = [@"@" stringByAppendingString:self.replyingToUser.screenName];
    
    [self.replyTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)replyAction:(UIBarButtonItem *)sender {
    [[APIManager shared] postReplyWithText:self.replyTextView.text user:self.replyingToUser completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else{
            [self.delegate didReply:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }

       
    }];
    
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
