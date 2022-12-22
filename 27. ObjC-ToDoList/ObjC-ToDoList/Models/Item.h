//
//  Item.h
//  ObjC-ToDoList
//
//  Created by Mutlu Çalkan on 22.12.2022.
//

#import <Foundation/Foundation.h>


@interface Item : NSObject

//Properties
@property NSString *name;
@property NSString *topic;

//Initializer
- (instancetype)initWithName: (NSString *)name andTopic: (NSString *)topic;

//Methods
+ (NSArray *)fetchItems;


@end

