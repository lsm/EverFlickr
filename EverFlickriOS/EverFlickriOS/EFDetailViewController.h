//
//  EFDetailViewController.h
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFDetailViewController : UIViewController <UIScrollViewDelegate>

@property (copy, nonatomic) NSURL *imageUrl;

- (id)initWithImageUrl:(NSURL *)url;

@end
