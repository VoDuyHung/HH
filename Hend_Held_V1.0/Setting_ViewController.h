//
//  Setting_ViewController.h
//  Hand Held
//
//  Created by Toan Nguyen Duc on 11/14/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Setting_ViewController : UIViewController

- (IBAction)btn_Save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *btn_LimitTrangChu;
@property (weak, nonatomic) IBOutlet UITextField *btn_limitTinCon;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)indexChanged:(UISegmentedControl *)sender;

@end
