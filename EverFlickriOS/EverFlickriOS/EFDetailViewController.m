//
//  EFDetailViewController.m
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

#import "EFDetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface EFDetailViewController ()

@end

@implementation EFDetailViewController

- (id)initWithImageUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.imageUrl = url;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"Detail View";

    // Adjust image size based on view to have a margin on top and bottom.
    CGRect frame = self.view.bounds;
    frame.origin.y = 10;
    frame.size.height -= 84;

    // Create and load the image
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImageWithURL:self.imageUrl];
    
    [self.view addSubview:imageView];
}

@end
