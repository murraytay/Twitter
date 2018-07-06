//
//  ComposeViewController.m
//  twitter
//
//  Created by Taylor Murray on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import <UIKit+AFNetworking.h>
@interface ComposeViewController ()

@end

@implementation ComposeViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.composeTextView.delegate = self;
    
    NSString *endString = @" characters left";
    int characterLimit = 140;
    int charactersLeft = characterLimit - self.composeTextView.text.length;
    NSString *left = [NSString stringWithFormat:@"%d",charactersLeft];
    self.charactersLeftLabel.text = [left stringByAppendingString:endString];
    
    [self.profilePicImage setImageWithURL:self.profilepicURL];
    
    // Do any additional setup after loading the view.
    [self.composeTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 140;
    NSString *newText = [self.composeTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    return newText.length < characterLimit;
    
}
- (void)textViewDidChange:(UITextView *)textView{
    NSString *endString = @" characters left";
    int characterLimit = 140;
    int charactersLeft = characterLimit - self.composeTextView.text.length;
     NSString *left = [NSString stringWithFormat:@"%d",charactersLeft];
    self.charactersLeftLabel.text = [left stringByAppendingString:endString];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetAction:(UIBarButtonItem *)sender {
    [[APIManager shared] postStatusWithText:self.composeTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
    
}
@end
