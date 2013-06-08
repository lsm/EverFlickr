//
//  EFRestFlickr.m
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

#import "EFRestFlickr.h"
#import "AFJSONRequestOperation.h"

@implementation EFRestFlickr

// Default flickr settings.
static NSString *_apiKey = @"220533323dd585327987433c344a4062";
static NSString *_apiUrl = @"http://api.flickr.com/services/rest/?format=json&nojsoncallback=1";

+ (NSString *)dictToQuery:(NSDictionary *)dict
{
    NSMutableArray *paramArray = [NSMutableArray array];
    
    // Suppose both key and value are string.
    for (NSString *key in dict) {
        NSString *value = [dict objectForKey:key];
        NSString *param = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [paramArray addObject:param];
    }

    return [paramArray componentsJoinedByString:@"&"];
}

+ (void)request:(NSString *)endpoint withParams:(NSDictionary *)params success:(void (^)(id, NSHTTPURLResponse *))success failure:(void (^)(NSError *, id))failure
{
    NSMutableString *urlString = [NSMutableString stringWithString:_apiUrl];
    [urlString appendFormat:@"&method=flickr.%@&api_key=%@&", endpoint, _apiKey];
    [urlString appendString:[EFRestFlickr dictToQuery:params]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(JSON, response);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        failure(error, JSON);
    }];

    [operation start];
}

+ (NSURL *)getPhotoURLById:(NSString *)pid farm:(NSString *)fid server:(NSString *)sid secret:(NSString *)sec
{
    NSString *urlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", fid, sid, pid, sec, @"n"];
    return [NSURL URLWithString:urlString];
}

@end
