//
//  HideBrick.m
//  Catty
//
//  Created by Mattias Rauter on 16.09.12.
//  Copyright (c) 2012 Graz University of Technology. All rights reserved.
//

#import "HideBrick.h"

@implementation HideBrick

- (void)performOnSprite:(Sprite *)sprite fromScript:(Script*)script
{
    NSLog(@"Performing: %@", self.description);
    
    [sprite hide];
}

#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"HideBrick"];
}

@end
