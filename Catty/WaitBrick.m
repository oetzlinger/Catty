//
//  WaitBrick.m
//  Catty
//
//  Created by Mattias Rauter on 17.04.12.
//  Copyright (c) 2012 Graz University of Technology. All rights reserved.
//

#import "WaitBrick.h"
#import "Script.h"

@implementation WaitBrick

@synthesize timeToWaitInMilliseconds = _timeToWaitInMilliseconds;

- (void)performOnSprite:(Sprite *)sprite fromScript:(Script*)script
{
    NSLog(@"Performing: %@", self.description);
    
    [script waitTimeInMilliSecs:self.timeToWaitInMilliseconds.floatValue];
    
//    [sprite wait:[self.timeToWaitInMilliseconds intValue] fromScript:script];
    
//    float sleepTime = ((float)self.timeToWaitInMilliseconds.intValue)/1000;
//    NSLog(@"wating for %f seconds", sleepTime);
//    NSLog(@"---- BEFORE SLEEP -----");
//    [NSThread sleepForTimeInterval:sleepTime];
//    NSLog(@"---- AFTER SLEEP ------");

}

#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"WaitBrick (%d Milliseconds)", self.timeToWaitInMilliseconds.intValue];
}

@end
