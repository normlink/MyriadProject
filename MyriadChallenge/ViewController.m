//
//  ViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/13/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    __weak IBOutlet UILabel *labelError;
    __weak IBOutlet UITextField *textUsername;
    
    __weak IBOutlet UITextField *textPassword;
    __weak IBOutlet UISwitch *rememberSwitch;
    
}
- (IBAction)logIn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    textUsername.delegate = self;
    textPassword.delegate = self;
    
    UITapGestureRecognizer *tapDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismissKeyboard:)];
    [self.view addGestureRecognizer:tapDismiss];
    
    textUsername.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    
}

-(void)tapDismissKeyboard:(UITapGestureRecognizer *)sender{
    [textUsername resignFirstResponder];
    [textPassword resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (labelError.alpha == 1.0f) {
        labelError.alpha = 0.0f;
    }}


- (IBAction)logIn:(id)sender {
    if ([textUsername.text isEqualToString:@"Lancelot"] && [textPassword.text isEqualToString:@"arthurDoesntKnow"]) {
        if (rememberSwitch.on == YES) {
            [[NSUserDefaults standardUserDefaults] setValue:textUsername.text forKey:@"Username"];
            [[NSUserDefaults standardUserDefaults] synchronize]; //need this to work with simulator
        } else if (rememberSwitch.on == NO){
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Username"];
        }
        [self performSegueWithIdentifier:@"toQuestVC" sender:self];
    } else {
        labelError.alpha = 1.0f;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
