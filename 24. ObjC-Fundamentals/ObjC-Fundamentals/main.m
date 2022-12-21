//
//  main.m
//  ObjC-Fundamentals
//
//  Created by Mutlu Çalkan on 21.12.2022.
//

//MARK: - Frameworks
#import <Foundation/Foundation.h>
//(Swift) import Foundation
#import "Person.h" //Everytime implement the header file (.h)

//MARK: - Creating Function
//(Swift) Creating a Function in Swift
//func add(num1: Int, num2: Int) -> Int{
//  return num1 + num2
//}

//(C) Creating a Function in C Language
int add(int num1, int num2) {
    return  num1 + num2;
}

//'main' function below is C type function.
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        //MARK: - Print
        NSLog(@"Hello, World!");
        //(Swift) print("Hello, World!")
        
        //Calling the function created on top of the 'main' function.
        int result = add(10, 22);
        NSLog(@"The result is %i.",result);
        
        
        //MARK: - Declare a String
        //Constants
        //(Swift) let name : String = "Mutlu".
        NSString *name = @"Mutlu";
        NSLog(@"The person's name is %@.",name);
        
        //Variable
        //(Swift) var language : String = "The language is".
        NSMutableString *language = [[NSMutableString alloc] initWithString:@"The language is"];
        NSLog(@"message: %@",language);
        
        //MARK: - Calling a ObjC Function
        //[instance methodName];
        //[class methodName];
        //(Swift) language.append(" Objective-C.")
        [language appendString:@" Objective-C."];
        NSLog(@"complete message: %@",language);
        
        //MARK: - Array
        //(Swift) let programmingStacks = ["Objective-C"];
        NSArray *programmingStacks = @[@"Objective-C", @"Swift", @"C", @"Python"];
        
        //(Swift) var raceTypes = [String]()
        NSMutableArray *raceTypes = [[NSMutableArray alloc] init];
        //(Swift) raceTypes.append("Marathon")
        [raceTypes addObject:@"Marathon"];
        [raceTypes addObject:@"10k"];
        [raceTypes addObject:@"Half marathon"];
        [raceTypes addObject:@"Triathlon"];
        
        //MARK: - For Loop
        //(Swift):
        //for language in programmingStacks {
        // print(language)
        //}
        for (NSString *language in programmingStacks) {
            //MARK: - If Statement
            //(Swift) if language == "Swift" {
            //  print("\(language) is the best language ever!")
            //}
            if ([language isEqual:@"Swift"]) {
                NSLog(@"%@ is the best language ever!",language);
            }
        }
        
        for (NSString *raceType in raceTypes) {
            NSLog(@"Race type is %@.",raceType);
        }
        
        //MARK: - Create Instance of Person
        //Created Person file in this part.
        Person *mutlu = [[Person alloc] init];
        //call info
        [mutlu info];
        
        
        //MARK: - Dictionary
        //Constant
        //(Swift) let placesDict = ["New York" : "Brooklyn", "Sweden" : "Malmo"]
        NSDictionary *placesDict = @{@"New York" : @"Brooklyn", @"Sweden" : @"Malmo"};
        //key: New York, value: Brooklyn
        for (NSString *placeKey in placesDict){
            NSString *placeValue = placesDict[placeKey];
            NSLog(@"The place key is %@ and the value is %@.",placeKey,placeValue);
        }
        
        //Variable
        NSMutableDictionary *platform = [[NSMutableDictionary alloc]init];
        [platform setObject:@"iOS apps" forKey:@"Swift"];
        [platform setObject:@"Androind apps" forKey:@"Java"];
        
        NSLog(@"Currently have %lu stacks.",platform.count); //%lu means unsigned long for integers.
        
        //MARK: - Call The Class Methods
        NSArray *people = [Person allPeople];
        for (Person *person in people) {
            NSLog(@"The person's name is %@.", person.name);
        }
    
        //Call the first person of the array
        Person *firstPerson = people[0];
        NSLog(@"The first person is %@.", firstPerson.name);
    }
    return 0;
}
