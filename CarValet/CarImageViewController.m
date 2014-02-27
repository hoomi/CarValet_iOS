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
}

- (void) setupScrollContent
{
    NSMutableArray *imageViews = [NSMutableArray new];
    
    CGFloat atX = 0.0;
    CGFloat maxHeight = 0.0;
    UIImage *carImage;
    UIImageView *atImageView;
    
    for (NSString *atCarImageName in carImagesArray) {
        carImage = [UIImage imageNamed:atCarImageName];
        atImageView = [[UIImageView alloc] initWithImage:carImage];
        atImageView.frame = CGRectMake(atX, 0.0, atImageView.bounds.size.width, atImageView.bounds.size.height);
        [imageViews addObject:atImageView];
        
        atX += atImageView.bounds.size.width;
        if (atImageView.bounds.size.height > maxHeight) {
            maxHeight = atImageView.bounds.size.height;
        }
    }
    UIView* carImageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, atX,maxHeight)];
    for (UIImageView *atImageView in imageViews) {
        [carImageContainerView addSubview:atImageView];
    }
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
	// Do any additional setup after loading the view.
    carImagesArray = @[ @"Acura-16.jpg", @"BMW-11.jpg", @"BMW-13.jpg",
                       @"Cadillac-13.jpg", @"Car-39.jpg",
                       @"Lexus-15.jpg", @"Mercedes Benz-106.jpg",
                       @"Mini-11.jpg", @"Nissan Leaf-4.jpg",
                       @"Nissan Maxima-2.jpg" ];
    [self setupScrollContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
