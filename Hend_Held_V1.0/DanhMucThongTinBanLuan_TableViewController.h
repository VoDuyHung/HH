//
//  DanhMucThongTinBanLuan_TableViewController.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DanhMucThongTinBanLuan_TableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIPrinterPickerControllerDelegate, NSURLSessionDelegate>{
    IBOutlet UITableView *tableData;
}


@end
