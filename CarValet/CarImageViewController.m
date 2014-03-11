//
//  CarImageViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 26/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarImageViewController.h"

@interface CarImageViewController ()

@end

@implementation CarImageViewController
{
    NSArray* carImagesArray;
    UIView *carImageContainerView;
    NSInteger currentCarIndex;
}

- (void) setupScrollContent
{
    
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    CGFloat totalWidth = scrollWidth * [carImagesArray count];
    
    if (carImageContainerView != nil) {
        [carImageContainerView removeFromSuperview];
    }
    carImageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, totalWidth,self.scrollView.frame.size.height)];
    
    CGFloat atX = 0.0;
    CGFloat maxHeight = 0.0;
    UIImage *carImage;
    UIImageView *atImageView;
    
    for (NSString *atCarImageName in carImagesArray) {
        carImage = [UIImage imageNamed:atCarImageName];
        CGFloat scale = scrollWidth/carImage.size.width;
        
        atImageView = [[UIImageView alloc] initWithImage:carImage];
        CGFloat newHeight = atImageView.bounds.size.height * scale;
        atImageView.frame = CGRectMake(atX, 0.0, scrollWidth, newHeight);
        if (newHeight > maxHeight) {
            maxHeight = newHeight;
        }
        atX += scrollWidth;
        [carImageContainerView addSubview:atImageView];
    }
    
    CGRect newFrame =  carImageContainerView.frame;
    newFrame.size.height = maxHeight;
    carImageContainerView.frame = newFrame;

    [self.scrollView addSubview:carImageContainerView];
    self.scrollView.contentSize = carImageContainerView.bounds.size;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resetZoomButton.enabled = NO;
    self.navigationController.toolbarHidden = YES;
    carImagesArray = @[ @"Yellow-Lamborghini.jpg",@"Acura-16.jpg", @"BMW-11.jpg", @"BMW-13.jpg",
                       @"Cadillac-13.jpg", @"Car-39.jpg",
                       @"Lexus-15.jpg", @"Mercedes Benz-106.jpg",
                       @"Mini-11.jpg", @"Nissan Leaf-4.jpg",
                       @"Nissan Maxima-2.jpg" ];
    [self setupScrollContent];
    [self updateCarNumberLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self setupScrollContent];
    [self scrollToCarIndex:currentCarIndex];
}

- (void) updateCarNumberLabel
{
    NSInteger carIndex = [self carIndexForPoint:self.scrollView.contentOffset];
    
    NSString *localizedString = NSLocalizedStringWithDefaultValue(@"CarNumberLabel",@"EditScreen",[NSBundle mainBundle],@"Car Number",@"Label for the index number of the current car");

    NSString *carNumberText = [NSString stringWithFormat:@"%@: %ld",localizedString,carIndex + 1];
    self.carNumberLabel.text = carNumberText;
    currentCarIndex = carIndex;
}

- (NSInteger) carIndexForPoint:(CGPoint) thePoint
{
    if (thePoint.x == 0) {
        return 0;
    }
    CGFloat pageWidth = self.scrollView.frame.size.width;
    pageWidth *= self.scrollView.zoomScale;
    
    return (NSInteger)(thePoint.x/pageWidth);
}

- (void) scrollToCarIndex:(NSInteger) carIndex
{
    UIView *scrolledToView = [[carImageContainerView subviews] objectAtIndex:carIndex];
    float x = scrolledToView.frame.origin.x * self.scrollView.zoomScale;
    [self.scrollView scrollRectToVisible:CGRectMake(x,0.0,scrolledToView.frame.size.width,self.scrollView.frame.size.height)  animated:YES];
}

#pragma UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return carImageContainerView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.resetZoomButton.enabled = scale != 1.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCarNumberLabel];
}

#pragma Actions

- (IBAction)resetZoom:(id)sender {
    [self.scrollView setZoomScale:1.0 animated:YES];
    [self.resetZoomButton setEnabled:NO];
}
@end
