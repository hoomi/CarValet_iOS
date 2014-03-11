//
//  CarTableViewCell.m
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarTableViewCell.h"
#import "CDCar.h"
#import "Utils.h"

@implementation CarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell
{
    NSString *unknownString = NSLocalizedStringWithDefaultValue(@"Unknown", nil, [NSBundle mainBundle], @"Unknown", @"Localized string for unknown");
    NSString *make = (self.displayedCar.make == nil) ? unknownString : self.displayedCar.make;
    NSString *model = (self.displayedCar.model == nil) ? unknownString : self.displayedCar.model;
    self.makeModelLabel.text = [NSString stringWithFormat:@"%@ %@ %@",
                           [Utils localizeDateWithYear:[self.displayedCar.year integerValue]],make,model];
    
    NSString *dateStr = [NSDateFormatter localizedStringFromDate:self.displayedCar.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    self.dateCreatedLabel.text = dateStr;

    
}

@end
