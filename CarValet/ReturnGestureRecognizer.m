//
//  ReturnGestureRecognizer.m
//  CarValet
//
//  Created by Hooman Ostovari on 13/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ReturnGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

#define kStrokeXDelta 5.0f
#define kStrokeYDelta 2.0f
#define kPhaseZero      0
#define kPhaseOne       1
#define kPhaseTwo       2
#define kPhaseThree     3
#define kPhaseFour      4


@implementation ReturnGestureRecognizer
{
    NSInteger strokePhase;
    CGPoint firstTap;
}

-(void)reset
{
    [super reset];
    
    strokePhase = 0;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (([touches count] != 1) || ([[touches.anyObject view] isKindOfClass:[UIControl class]])) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    firstTap = [touches.anyObject locationInView:self.view.superview];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed || self.state == UIGestureRecognizerStateRecognized) {
        return;
    }
    
    UIView *superview = self.view.superview;
    CGPoint currPoint = [touches.anyObject locationInView:superview];
    CGPoint prevPoint = [touches.anyObject previousLocationInView:superview];
    
    if ((strokePhase == kPhaseZero) && (currPoint.y - firstTap.y > 10.0) && (currPoint.y >= prevPoint.y)) {
        strokePhase = kPhaseOne;
    } else if ((strokePhase == kPhaseOne) && (currPoint.x - prevPoint.x > kStrokeXDelta) && (prevPoint.y - currPoint.y > kStrokeYDelta)){
        strokePhase = kPhaseTwo;
    } else if (strokePhase == kPhaseTwo && (currPoint.x - prevPoint.x > kStrokeXDelta) && (prevPoint.y - currPoint.y > kStrokeYDelta)) {
        strokePhase = kPhaseThree;
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.state = UIGestureRecognizerStateFailed;
}
@end
