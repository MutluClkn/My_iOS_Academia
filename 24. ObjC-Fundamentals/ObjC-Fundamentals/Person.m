//
//  Person.m
//  ObjC-Fundamentals
//
//  Created by Mutlu Çalkan on 21.12.2022.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@implementation Person

//We implement the method created in the header file.

//Class method
+ (NSArray *)allPeople{
    Person *ahmet = [[Person alloc] init];
    ahmet.name = @"Ahmet";
    
    Person *ali = [[Person alloc] init];
    ali.name = @"Ali";
    
    NSArray *people = @[ahmet, ali];
    return people;
}

//Instance method
- (void)info{
    NSLog(@"This is a person.");
}
@end
