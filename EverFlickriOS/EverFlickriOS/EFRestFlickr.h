//
//  EFRestFlickr.h
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

@interface EFRestFlickr : NSObject

// Helper function for converting dictionary to query string.
+ (NSString *)dictToQuery:(NSDictionary *)dict;

// Simplified api request method.
+ (void)request:(NSString *)endpoint withParams:(NSDictionary *)params
        success:(void (^)(id JSON, NSHTTPURLResponse *response))success
        failure:(void (^)(NSError *error, id JSON))failure;

// Generate photo url.
+ (NSURL *)getPhotoURLById:(NSString *)pid farm:(NSString *)fid server:(NSString *)sid secret:(NSString *)sec;

@end
