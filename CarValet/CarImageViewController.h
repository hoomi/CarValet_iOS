//
//  CarImageViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 26/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarImageViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetZoomButton;
- (IBAction)resetZoom:(id)sender;

@end
