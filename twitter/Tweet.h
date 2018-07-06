//
//  Tweet.h
//  twitter
//
//  Created by Taylor Murray on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Tweet : NSObject
@property (nonatomic, strong) NSString *idStr; 
@property (strong, nonatomic) NSString *text;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL retweeted;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *createdAtString;
@property (strong, nonatomic) NSArray *mediaArray;
@property (nonatomic) int replyCount;
//for retweets
@property (strong, nonatomic) User *retweetedByUser;

+(NSMutableArray *)tweetsWithArray:(NSMutableArray *)dictionaries;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
