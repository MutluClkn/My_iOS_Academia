//
//  ViewController.m
//  ObjC-Login
//
//  Created by Mutlu Çalkan on 20.12.2022.
//

#import "ViewController.h"

//MARK: - ViewController Interface
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@end


//MARK: - ViewController Implementation
@implementation ViewController

//MARK: - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username = @"mutlu";
    self.password = @"1234";
    
    [self.notificationLabel setText:@""];
}

//MARK: - Actions
- (IBAction)loginButtonDidPress:(UIButton *)sender {
    
    BOOL isUserEqual = [self.username isEqualToString:[self.usernameTextField text]];
    BOOL isPasswordEqual = [self.password isEqualToString:[self.passwordTextField text]];
    
    if ( isUserEqual && isPasswordEqual ){
        NSLog(@"SUCCESS!");
        [self.notificationLabel setText:@"Congratilations! You have logged in."];
    }else{
        NSLog(@"FAILURE!");
        [self.notificationLabel setText:@"Your username or password was incorrect."];
    }
}

//MARK: - Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}
@end
