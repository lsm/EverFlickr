//
//  EFImageViewCell.m
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

#import "EFImageViewCell.h"

@implementation EFImageViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
    }
    return self;
}

@end
