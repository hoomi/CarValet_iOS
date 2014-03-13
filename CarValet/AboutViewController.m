//
//  AboutViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 05/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "AboutViewController.h"
#import "DragViewGesture.h"

#define kPulseAmount 6.0f
#define kSpaceAmount kPulseAmount / 2.0f

@interface AboutViewController ()
{
    BOOL draggedOnce;
    BOOL paused;
    NSInteger pulsCount;
}

@end

@implementation AboutViewController

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
    draggedOnce = NO;
    paused = NO;
    pulsCount = 0;

    DragViewGesture *dragGesture = [[DragViewGesture alloc]init];
    [self.taxiView addGestureRecognizer:dragGesture];
    dragGesture.delegate = self;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!draggedOnce) {
        pulsCount = 0;
        paused = NO;
        [self pulseTaxi];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    paused = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pulsing code

-(void) pulseTaxi
{
    if (!paused && !draggedOnce) {
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.taxiWidth.constant += kPulseAmount;
            self.taxiHeight.constant += kPulseAmount;
            self.labelTaxiSpace.constant -= kSpaceAmount;
            
            [self.view layoutIfNeeded];
            
            pulsCount ++;
        } completion:^(BOOL finished){
            self.taxiWidth.constant -= kPulseAmount;
            self.taxiHeight.constant -= kPulseAmount;
            self.labelTaxiSpace.constant += kSpaceAmount;
            
            [self.view layoutIfNeeded];
            
            if (!draggedOnce) {
                NSTimeInterval delay = 1.0f;
                if (pulsCount > 1) {
                    pulsCount = 0;
                    
                    delay = 2.8f;
                }
                
                [self performSelector:@selector(pulseTaxi) withObject:nil afterDelay:delay];
            }
        }];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (!draggedOnce && [gestureRecognizer isKindOfClass:[DragViewGesture class]]) {
        draggedOnce = YES;
    }
    
    return YES;
}



@end
