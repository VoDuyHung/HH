//
//  ViewController.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 9/24/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController{


    NSString *HASH_KEY;
    NSString *USER_NAME;
    UIActivityIndicatorView *activityIndicator;
    NSDictionary *infodictionary;
    UISwitch *mySwitch;


}
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


@property (nonatomic, retain) NSString *HASH_KEY;
@property (nonatomic, retain) NSString *USER_NAME;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lable1;

- (IBAction)login_button:(id)sender;



@end

