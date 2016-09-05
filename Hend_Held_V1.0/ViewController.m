//
//  ViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 9/24/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface ViewController ()<MBProgressHUDDelegate, UITextFieldDelegate> {}
@end
@implementation ViewController{}
@synthesize USER_NAME = USER_NAME;
@synthesize HASH_KEY=HASH_KEY;
@synthesize activityIndicator=_activityIndicator;
- (IBAction)userTappedView:(UIGestureRecognizer*)tapGestureRecognizer
{
    [self.view endEditing:YES];
}
//hide keyboard when user input username and password
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // ẩn bàn phím khi sửa xong
    [self.username endEditing:YES];
    [self.password endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.username setPlaceholder:@""];
    [self.username setPlaceholder:@""];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view= self.view;
    //Custom position and size of switch
    CGRect frame = CGRectMake(40, 327.0, 0, 0);
    mySwitch = [[UISwitch alloc] initWithFrame:frame];
    mySwitch.transform = CGAffineTransformMakeScale(0.40, 0.35);
    mySwitch.onTintColor = [UIColor colorWithRed:0.043f green:0.318f blue:0.635f alpha:1.00f];
    [mySwitch setOn:YES];
    [mySwitch addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    
    //Icon tk và mk
    UIView * containttk = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
    containttk.backgroundColor = [UIColor clearColor];
    UIImageView *icontk= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [icontk setImage:[UIImage imageNamed:@"48x48"]];
    [containttk addSubview:icontk];
    [self.username setRightView:containttk];
    [self.username setRightViewMode:UITextFieldViewModeAlways];
    
    UIView * containmk= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
    UIImageView * iconmk = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [iconmk setImage:[UIImage imageNamed:@"mk48"]];
    [containmk addSubview:iconmk];
    [self.password setRightView:containmk];
    [self.password setRightViewMode:UITextFieldViewModeAlways];
    // Checking internet connection--------------------------------------------------
    Reachability *reachTest = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [reachTest  currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)){
        /// Create an alert if connection doesn't work,no internet connection
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối Internet.Hãy bật WIFI hoặc 3G để ứng dụng hoạt động!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
    else{
    //maintance login
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *saveUsername = [def stringForKey:@"textField1Text"];
    NSString *savePassword = [def stringForKey:@"textField2Text"];
    //Save usernae+password
    self.username.text=saveUsername;
    self.password.text=savePassword;
    
    }
    [mySwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lable1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
   [view addConstraint:[NSLayoutConstraint constraintWithItem:mySwitch
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.lable1
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:mySwitch
                                                     attribute:NSLayoutAttributeBaseline
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.lable1
                                                     attribute:NSLayoutAttributeBaseline
                                                    multiplier:1.0
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:mySwitch
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.lable1
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Xác Nhận"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
  
}
- (IBAction)buttonClicked:(UIButton *)sender {
    if ([mySwitch isOn]) {
        [mySwitch setOn:NO animated:YES];
    } else {
        [mySwitch setOn:YES animated:YES];
    }
}
- (IBAction)login_button:(id)sender {

          if ([[self.username text] isEqualToString:@""] || [[self.password text]isEqualToString:@""]) {
            [self alertStatus:@"Vui lòng nhập Email hoặc mật khẩu!" :@"Đăng nhập thất bại!" :0];
          }else {
              @try {
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
              NSString *post =[[NSString alloc] initWithFormat:@"action=authenticate&username=%@&password=%@",[self.username text],[self.password text]];
              NSURL *url=[NSURL URLWithString:@"http://www.handheld.com.vn/api.php?"];
              NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
              NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
              NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
              //reponse json
              [request setURL:url];
              [request setHTTPMethod:@"POST"];
              [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
              [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
              [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
              [request setHTTPBody:postData];
                  
                  NSHTTPURLResponse *response = nil;
                  NSError *error = nil;
                  NSData *urlData=[NSURLConnection sendSynchronousRequest:request
                                                        returningResponse:&response
                                                                    error:&error];
                  if (!urlData){
                      NSLog(@"Error: %@", [error localizedDescription]);
                  
                  }
                  
                  
                  
             // NSError *error = [[NSError alloc] init];
             
              //NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
              NSString *responseData = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
              NSMutableString *str_01 = [NSMutableString stringWithString:responseData];
                  NSLog(@"ket qua: %@",str_01);
                  
              //if length of MD5>90 is login succes
              if(str_01.length==91) {
                  NSString *str_02;
                  str_02 = [str_01 substringWithRange:NSMakeRange(9, 80)];
                  NSString *valueToSave = str_02;
                  [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"keyMD5"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  //save username
                  USER_NAME=self.username.text;
                  [[NSUserDefaults standardUserDefaults] setObject:USER_NAME forKey:@"USER_NAME"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  //maintance login-------save username and password on textfeild---------------------
                  if(mySwitch.on == YES)
                  {
                      //save username
                      NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                      NSString *textField1Text = self.username.text;
                      [defaults setObject:textField1Text forKey:@"textField1Text"];
                      [defaults synchronize];
                      //save password
                      NSString *textField2Text = self.password.text;
                      [defaults setObject:textField2Text forKey:@"textField2Text"];
                      [defaults synchronize];
                  } else
                  {
                      NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                      [defaults setObject:@"" forKey:@"textField1Text"];
                      [defaults setObject:@"" forKey:@"textField2Text"];
                      [defaults synchronize];
                  }
                //handle wating when login success
                //custom alert when user wait login-------------------------------------------------------------------------------
                  UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
                  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
                  hud.labelText = @"Đang tải dữ liệu...";
                  hud.dimBackground = YES;
                  [self performSegueWithIdentifier:@"login_success" sender:self];
                  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
                  [hud hide:YES];
             }
              else
              {
                [self alertStatus:@"Sai tên đăng nhập hoặc mật khẩu!\nVui lòng nhập lại!" :@"Đăng nhập thất bại!" :0];
              } } @catch (NSException *exception) {
                  UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
                  [myAlert show];
              }
                  //try-catch when lost internet when loading data
              
          }
       

}

@end
