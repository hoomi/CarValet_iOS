//
//  MakeModelEditViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "MakeModelEditViewController.h"

@interface MakeModelEditViewController ()

@end

@implementation MakeModelEditViewController

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
    self.myNavigationItem.title = [self.delegate titleText];
    
    self.editLabel.text = [self.delegate editLabelText];
    self.editField.text = [self.delegate editFieldText];
    self.editField.placeholder = [self.delegate editFieldPlaceholderText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editCanceled:(id)sender {
    [self
     dismissViewControllerAnimated:YES
     completion:^{
        NSLog(@"Cancelled successfully");
    }];
}

- (IBAction)editDone:(id)sender {
    [self.delegate editDone:self.editField.text];
    [self
     dismissViewControllerAnimated:YES
     completion:^{
         NSLog(@"Edit done successfully");
    }];
}
@end
