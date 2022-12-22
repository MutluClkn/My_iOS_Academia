//
//  ViewController.m
//  ObjC-ToDoList
//
//  Created by Mutlu Çalkan on 22.12.2022.
//

#import "ItemsViewController.h"
#import "Item.h"

@interface ItemsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *items;

@end

@implementation ItemsViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    
    [self configureNavBar];
    
    NSArray *itemArray = [Item fetchItems];
    
    self.items = [[NSMutableArray alloc] initWithArray:itemArray];
    
}

#pragma mark - ConfigureNavBar
- (void)configureNavBar{
    //Image for the bar button item
    UIImage *image = [UIImage systemImageNamed:@"plus"];
    
    //Bar button item
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(addItemButtonPressed)];
    
    //Set the plusButton as the right bar button item
    self.navigationItem.rightBarButtonItem = plusButton;
    
    //Set the title of navigation item
    self.navigationItem.title = @"To-Do List";
}

#pragma  mark - AddItemButtonPressed
- (void)addItemButtonPressed{
    
    //Initialize alert controller
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a new to-do list item" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    //Add two text fields to the alert controller
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    //Add placeholder text to the text fields
    alertController.textFields[0].placeholder = @"Enter the name of the item";
    alertController.textFields[1].placeholder = @"Enter the topic";
    
    //Define action items
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Inser the new item
        NSString *name = alertController.textFields[0].text;
        NSString *topic = alertController.textFields[1].text;
        Item *newItem = [[Item alloc] initWithName:name andTopic:topic];
        [self.items addObject:newItem];
        
        //Create an indexpath at the end of items array
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count - 1 inSection:0];
        
        //Insert indexpath into table view
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    //Add action items
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    Item *item = self.items[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.topic;
    
    return cell;
}


@end
