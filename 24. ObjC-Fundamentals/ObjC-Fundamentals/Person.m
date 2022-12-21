//
//  Person.m
//  ObjC-Fundamentals
//
//  Created by Mutlu Çalkan on 21.12.2022.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@implementation Person

//Implement the method created in the header file.
//MARK: - Class method
+ (NSArray *)allPeople{
    Person *ahmet = [[Person alloc] init];
    ahmet.name = @"Ahmet";
    
    Person *ali = [[Person alloc] init];
    ali.name = @"Ali";
    
    NSArray *people = @[ahmet, ali];
    return people;
}

//MARK: - Instance method
- (void)info{
//Changed this -> NSLog(@"This is a person.");
//Into this:
    NSLog(@"The person's name is %@.",self.name);
}

//MARK: - Initializer
//Swift Example:
//init(frame:CGRect){
//  super.init(frame:frame)
//}
- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        //initializer properties
        self.name = name;
    }
    return self;
}


@end
