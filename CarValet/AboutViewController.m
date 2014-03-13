//
//  AboutViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 05/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "AboutViewController.h"
#import "DragViewGesture.h"

@interface AboutViewController ()

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
    DragViewGesture *dragGesture = [[DragViewGesture alloc]init];
    [self.taxiView addGestureRecognizer:dragGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
