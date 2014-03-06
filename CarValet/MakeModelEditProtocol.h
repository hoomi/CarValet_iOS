//
//  MakeModelEditProtocol.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MakeModelEditProtocol <NSObject>

- (NSString*) titleText;
- (NSString*) editLabelText;
- (NSString*) editFieldText;
- (NSString*) editFieldPlaceholderText;
- (void) editDone: (NSString*) textFieldValue;

@end
