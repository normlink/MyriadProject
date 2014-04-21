//
//  ViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/13/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController () {
    
    __weak IBOutlet UILabel *labelError;
    __weak IBOutlet UITextField *textUsername;
    
    __weak IBOutlet UITextField *textPassword;
    __weak IBOutlet UISwitch *rememberSwitch;
    
}
- (IBAction)logIn:(id)sender;
- (IBAction)signUp:(id)sender;

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
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

-(void)tapDismissKeyboard:(UITapGestureRecognizer *)sender{
    [textUsername resignFirstResponder];
    [textPassword resignFirstResponder];
}
//Parse now handles error message
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    if (labelError.alpha == 1.0f) {
//        labelError.alpha = 0.0f;
//    }
//}

- (IBAction)logIn:(id)sender {
    
    [PFUser logInWithUsernameInBackground:textUsername.text password:textPassword.text block:^(PFUser *user, NSError *error) {
        if (user) {
            if (rememberSwitch.on == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:textUsername.text forKey:@"Username"];
                [[NSUserDefaults standardUserDefaults] synchronize]; //need this to work with simulator
            } else if (rememberSwitch.on == NO){
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Username"];
            }
            [self performSegueWithIdentifier:@"toQuestVC" sender:self];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    //The following was utilized prior to Parse implementation:
    //    if ([textUsername.text isEqualToString:@"Lancelot"] && [textPassword.text isEqualToString:@"arthurDoesntKnow"]) {
    //        if (rememberSwitch.on == YES) {
    //            [[NSUserDefaults standardUserDefaults] setValue:textUsername.text forKey:@"Username"];
    //            [[NSUserDefaults standardUserDefaults] synchronize]; //need this to work with simulator
    //        } else if (rememberSwitch.on == NO){
    //            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Username"];
    //        }
    //        [self performSegueWithIdentifier:@"toQuestVC" sender:self];
    //    } else {
    //        labelError.alpha = 1.0f;
    //    }
}

- (IBAction)signUp:(id)sender {
    [self performSegueWithIdentifier:@"toSignUpVC" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
