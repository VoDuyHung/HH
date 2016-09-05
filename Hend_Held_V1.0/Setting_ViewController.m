//
//  Setting_ViewController.m
//  Hand Held
//
//  Created by Toan Nguyen Duc on 11/14/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Setting_ViewController.h"

@interface Setting_ViewController ()
@end
@implementation Setting_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn_LimitTrangChu.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfMainPage"];
    self.btn_limitTinCon.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
    NSInteger status = [[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] integerValue];
    self.segmentedControl.selectedSegmentIndex=status;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_Save:(UIButton *)sender {
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    //Number of Post----------------------------------------------------------
    int numberPostMainPage=[self.btn_LimitTrangChu.text intValue];
    int numberPostSubPage=[self.btn_limitTinCon.text intValue];
    if(numberPostMainPage==0&&numberPostSubPage==0){
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Vui lòng nhập số bài viết cho trang chủ và trang con!"delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];

    }
    else if(numberPostMainPage>0&&numberPostMainPage<=10000&&numberPostSubPage>0&&numberPostSubPage<=10000){
            NSString *save_NumMainPage=[NSString stringWithFormat:@"%d",numberPostMainPage];
            [defaults1 setObject :save_NumMainPage forKey:@"numberOfMainPage"];
            NSString *save_NumSubPage=[NSString stringWithFormat:@"%d",numberPostSubPage];
            [defaults1 setObject:save_NumSubPage forKey:@"numberOfSubPage"];
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Số bài viết đã được lưu!"delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
            [myAlert show];
            [defaults1 synchronize];
        [self viewDidLoad];
    }
    else{
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Vui lòng nhập lại số bài cho trang chủ nằm trong khoảng từ 1->10000 & số bài cho trang con nằm trong khoảng từ 1->10000!"delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
- (IBAction)indexChanged:(UISegmentedControl *)sender {
     NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
            break;
        case 1:
            [defaults2 setObject:@"1" forKey:@"sortBy"];
            [defaults2 synchronize];
            break;
        default: 
            break; 
    }
    
}
@end
