//
//  GalleryViewController.h
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NIToolbarPhotoViewController.h"


@interface GalleryViewController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource>

@property (strong, nonatomic) NSMutableArray *photos;

@property (strong, nonatomic) NSString *detail1;
@property (strong, nonatomic) NSString *detail2;


@end
