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
