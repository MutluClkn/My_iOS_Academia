//
//  Fellow.m
//  ObjC-Fundamentals
//
//  Created by Mutlu Çalkan on 21.12.2022.
//

#import <Foundation/Foundation.h>
#import "Fellow.h"

@implementation Fellow

//Override 'info' method.
- (void)info{
    NSLog(@"The fellow's name is %@.",self.name);
}

@end
