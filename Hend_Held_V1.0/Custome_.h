//
//  Custome_.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/5/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface Custome_ : UITableViewController< UITableViewDataSource,UITableViewDelegate,UIPrinterPickerControllerDelegate, NSURLSessionDelegate>{
    IBOutlet UITableView *tableData;
    ViewController *saveUserHash;
}

@property(nonatomic, retain) ViewController *saveUserHash;
@end
