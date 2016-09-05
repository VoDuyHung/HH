//
//  Comment_TableViewController.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/27/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comment_TableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableData;
    IBOutlet UIButton *alert_comment;
}
@end
