//
//  GalleryViewController.m
//  Ecocem
//
//  Created by Alan Mathews on 20/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"
#import "DetailViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController
@synthesize  photos = _photos;
@synthesize detail1 = _detail1;
@synthesize detail2 = _detail2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Hide tab bar menu from gallery
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
                     photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions
{
    UIImage *image = [self.photos objectAtIndex:photoIndex];
    *photoSize = NIPhotoScrollViewPhotoSizeOriginal;
    return image;
}

- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView
{
    return [self.photos count];
}

/**
 * Fetches a page that will be displayed at the given page index.
 *
 * You should always try to reuse pages by calling dequeueReusablePageWithIdentifier: on the
 * paging scroll view before allocating a new page.
 */
- (UIView<NIPagingScrollViewPage> *)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex
{
    // TODO (jverkoey Nov 27, 2011): We should make this sort of custom logic easier to build.
    UIView<NIPagingScrollViewPage>* pageView = nil;
    
    NSString* reuseIdentifier = NSStringFromClass([NIPhotoScrollView class]);
    pageView = [pagingScrollView dequeueReusablePageWithIdentifier:reuseIdentifier];
    if (nil == pageView) {
        pageView = [[NIPhotoScrollView alloc] init];
        pageView.reuseIdentifier = reuseIdentifier;
    }
    
    NIPhotoScrollView* photoScrollView = (NIPhotoScrollView *)pageView;
    photoScrollView.photoScrollViewDelegate = self.photoAlbumView;
    photoScrollView.zoomingAboveOriginalSizeIsEnabled = [self.photoAlbumView isZoomingAboveOriginalSizeEnabled];
    
    //CaptionedPhotoView* captionedView = (CaptionedPhotoView *)pageView;
    //captionedView.caption = @"Yo";
    
    return pageView;
}

- (void)loadView {
    [super loadView];
    
    self.photoAlbumView.dataSource = self;
    
    // This title will be displayed until we get the results back for the album information.
    self.title = @"1 of 2";
    
    [self.photoAlbumView reloadData];
}

- (IBAction)showInfo:(id)sender
{   
    DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    controller.detail1 = self.detail1;
    controller.detail2 = self.detail2;
    
    //controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
      
}

- (void)detailViewControllerDidFinish:(DetailViewController *)controller{
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:@"Project Info" style:UIBarButtonItemStyleBordered target:self action:@selector(showInfo:)];
    self.navigationItem.rightBarButtonItem = infoButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.photos = nil;
    self.detail1 = nil;
    self.detail2 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
