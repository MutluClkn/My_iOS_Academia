//
//  Person.h
//  ObjC-Fundamentals
//
//  Created by Mutlu Çalkan on 21.12.2022.
//

#import <Foundation/Foundation.h>

//MARK: - Create a class/subclass
@interface Person : NSObject //Inherits from NSObject.

//MARK: - Create a Method
//(Swift) func info() -> Void
//info method returns 'void'
//In the header file (.h) we just create the function, but we don't create the body(closure) of the function. Same with Protocols in Swift.
//Instance method
- (void)info;
// - (return type)functionName

//Class method
+ (NSArray *)allPeople;

//MARK: - Properties
//(Swift) let name : String
@property NSString *name;


@end
