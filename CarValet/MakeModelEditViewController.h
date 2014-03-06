//
//  MakeModelEditViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeModelEditProtocol.h"

@interface MakeModelEditViewController : UIViewController
@property (weak, nonatomic) id <MakeModelEditProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *editLabel;
@property (weak, nonatomic) IBOutlet UITextField *editField;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavigationItem;
- (IBAction)editCanceled:(id)sender;
- (IBAction)editDone:(id)sender;

@end
