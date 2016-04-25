//
//  ViewController.m
//  hello
//
//  Created by Wira on 4/18/16.
//  Copyright © 2016 Wira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UITextField *inputField;

@end

@implementation ViewController

- (IBAction)Enter {
    NSString *yourName = self.inputField.text;
    NSString *myName = @"Wira";
    NSString *message;
    
    if ([yourName length] == 0) {
        yourName = @"Weeww";
    }
    
    if ([yourName isEqualToString:myName]) {
        message = [NSString stringWithFormat:@"Hello %@ kita punya nama yang sama", yourName];
    } else{
        message = [NSString stringWithFormat:@"Hello %@", yourName];
    }
    
    self.messageLabel.text = message;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
