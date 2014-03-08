//
//  ViewCarProtocol.h
//  CarValet
//
//  Created by Hooman Ostovari on 07/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewCarProtocol <NSObject>

- (NSInteger) carToView;
- (void) carViewDone:(BOOL) dataUpdated;

@end
