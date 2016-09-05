//
//  Danh.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/16/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Danh : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIPrinterPickerControllerDelegate, NSURLSessionDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate,UISearchDisplayDelegate, UISearchControllerDelegate, UISearchBarDelegate>{
    IBOutlet UITableView *tableData;
    ViewController *saveUserHash;

}
@property(nonatomic, retain) ViewController *saveUserHash;

@property (weak, nonatomic) IBOutlet UISearchBar *Search_Bar;
- (IBAction)Search_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
