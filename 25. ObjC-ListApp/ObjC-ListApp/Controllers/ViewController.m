//
//  ViewController.m
//  ObjC-ListApp
//
//  Created by Mutlu Çalkan on 20.12.2022.
//

#import "ViewController.h"
#import "List.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<List *> *courses;

@end

@implementation ViewController

NSString *cellId = @"cell";
//NSArray *listArray = @[@"iPhone", @"iPad", @"Apple Watch", @"iMac", @"Macbook"];

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupList];
    [self fetchData];
    self.myTableView.dataSource = self;
}

-(void)setupList{
    self.courses = NSMutableArray.new;
    List *list = List.new;
    [self.courses addObject:list];
}

-(void)fetchData{
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        /*
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dummyString);
        */
        NSError *err;
        NSArray *courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"%@", err);
            return;
        }
        
        NSMutableArray<List *> *courses = NSMutableArray.new;
        for (NSDictionary *courseDict in courseJSON){
            NSString *name =  courseDict[@"name"];
            List *list = List.new;
            list.name = name;
            [courses addObject:list];
            
            self.courses = courses;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
            
        }
        
    }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    List *list = self.courses[indexPath.row];
    
    cell.textLabel.text = list.name;

    return cell;
}
@end
