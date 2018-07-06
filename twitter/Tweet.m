//
//  Tweet.m
//  twitter
//
//  Created by Taylor Murray on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "DateTools.h"
@implementation Tweet
+(NSMutableArray *)tweetsWithArray:(NSMutableArray *)dictionaries{
    NSMutableArray *tweetArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dic in dictionaries){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dic];
        [tweetArray addObject:tweet];
    }
    
    return tweetArray;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            dictionary = originalTweet;
        }
        
        self.replyCount = [dictionary[@"reply_count"] intValue];
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.mediaArray = dictionary[@"entities"][@"media"];
        NSDictionary *user = dictionary[@"user"];
        
        self.user = [[User alloc] initWithDictionary:user];
        
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //Configure the input format to parse the date
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        //Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
//        //configure output format
//        formatter.dateStyle = NSDateFormatterLongStyle;
//        formatter.timeStyle = NSDateFormatterNoStyle;
//        //convert date tp string
//        self.createdAtString = [formatter stringFromDate:date];
        //NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:date.timeIntervalSinceNow];
        //NSLog(@"Time Ago: %@", timeAgoDate.timeAgoSinceNow);
        self.createdAtString = date.timeAgoSinceNow;
        //Output:
        //Time Ago: 4 seconds ago
        //Time Ago: 4s
        NSLog(@"random for date");
    }
    return self;
}
@end
