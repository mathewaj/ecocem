//
//  GalleryViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NIToolbarPhotoViewController.h"
#import "DetailViewController.h"

@interface GalleryViewController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource, DetailViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos;

@end
