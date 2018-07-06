//
//  User.m
//  twitter
//
//  Created by Taylor Murray on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if(self){
        self.screenName = dictionary[@"screen_name"];
        self.name = dictionary[@"name"];
        self.profileURLString = dictionary[@"profile_image_url_https"];
        self.bannerURLString = dictionary[@"profile_banner_url"];
        self.followersCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"friends_count"];
        self.descriptionUser = dictionary[@"description"];
        self.id_str = dictionary[@"id_str"];
    }
    return self;
}
@end
