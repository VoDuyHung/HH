//
//  AddSubNode_TableViewController.h
//  Hand Held
//
//  Created by Toan Nguyen Duc on 12/1/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPSPageMenu.h"

@interface AddSubNode_TableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIPrinterPickerControllerDelegate, NSURLSessionDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate,UISearchDisplayDelegate, UISearchControllerDelegate, UISearchBarDelegate>


- (IBAction)Search:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Seach;

@property (weak, nonatomic) IBOutlet UISearchBar *Search_Bar;


@end
