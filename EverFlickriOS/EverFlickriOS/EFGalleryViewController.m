//
//  EFGalleryViewController.m
//  EverFlickriOS
//
//  Created by Liu Senmiao on 6/7/13.
//  Copyright (c) 2013 EverFlickr Co. All rights reserved.
//

#import "EFGalleryViewController.h"
#import "EFRestFlickr.h"
#import "EFImageViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "EFDetailViewController.h"

NSString *kImageCellID = @"EF_IMAGE_CELL";

@interface EFGalleryViewController ()
{
    NSMutableArray *_images;
}
@end

@implementation EFGalleryViewController

#pragma mark - View manipulation

- (void)loadView
{
    [super loadView];

    // Array for image urls.
    _images = [NSMutableArray array];
    
    self.title = @"EverFlickr";

    // Setup collection view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Additional setup for collection view.
    [self.collectionView registerClass:[EFImageViewCell class] forCellWithReuseIdentifier:kImageCellID];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];

    // Flickr API query parameters.
    NSDictionary *params = @{@"tags": @"party", @"tag_mode": @"all", @"per_page": @"21"};

    // Do the http request and handle results.
    [EFRestFlickr request:@"photos.search" withParams:params success:^(id JSON, NSHTTPURLResponse *response){
        NSArray *photos = [[JSON objectForKey:@"photos"] objectForKey:@"photo"];
        for (id photo in photos) {
            NSURL *photoUrl = [EFRestFlickr getPhotoURLById:[photo objectForKey:@"id"] farm:[photo objectForKey:@"farm"] server:[photo objectForKey:@"server"] secret:[photo objectForKey:@"secret"]];
            [_images addObject:photoUrl];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error, id JSON){
        NSLog(@"Flickr API Error: %@", error);
    }];
}

#pragma mark - PSTCollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Create and show the big photo.
    EFDetailViewController *detailViewController = [[EFDetailViewController alloc] initWithImageUrl:[_images objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:true];
}

#pragma mark - PSUICollectionViewDataSource Protocol

- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_images count];
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCellID forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[_images objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
