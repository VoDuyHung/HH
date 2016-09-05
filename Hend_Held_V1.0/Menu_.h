//
//  Menu_.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 9/24/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "AMSlideMenuMainViewController.h"
#import <UIKit/UIKit.h>
#import "SAMenuDropDown.h"
#import "ViewController.h"
#import "LMDropdownView.h"

@interface Menu_ : UIViewController<SAMenuDropDownDelegate, UITableViewDataSource,UITableViewDelegate,UIPrinterPickerControllerDelegate, NSURLSessionDelegate, LMDropdownViewDelegate>{
    IBOutlet UITableView *tableData;
    ViewController *saveUserHash;
    IBOutlet UIActivityIndicatorView *loading;
    UITableView *tableView1;
}
@property(nonatomic, retain) ViewController *saveUserHash;
@property (nonatomic, strong) IBOutlet UIView *ddMenu;
@property (nonatomic, strong) SAMenuDropDown *menuDrodown_Avatar;
@property (weak, nonatomic) IBOutlet UIButton *btn_Avartar;

-(IBAction)settingButton:(id)sender;
-(IBAction)MenuButton:(id)sender;


- (IBAction)btn_Persional:(id)sender;


@property (weak, nonatomic) IBOutlet UITableViewCell *TableView;



@property (weak, nonatomic) IBOutlet UILabel *lblLoading;





@end
