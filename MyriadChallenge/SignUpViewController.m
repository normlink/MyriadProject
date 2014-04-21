//
//  SignUpViewController.m
//  MyriadChallenge
//
//  Created by Yaniv Kerem on 4/20/14.
//  Copyright (c) 2014 Norm Gershon. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController (){
    
    __weak IBOutlet UISegmentedControl *segmentController;
    __weak IBOutlet UITextField *usernameText;
    __weak IBOutlet UITextField *passwordText;
    __weak IBOutlet UITextField *nameText;
    
}

- (IBAction)signUpUser:(id)sender;

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signUpUser:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = usernameText.text;
    user.password = passwordText.text;
    [user setObject:nameText.text forKey:@"name"];
    [user setObject:@(segmentController.selectedSegmentIndex) forKey:@"alignment"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"signUpToQuestsVC" sender:self];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Success!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
