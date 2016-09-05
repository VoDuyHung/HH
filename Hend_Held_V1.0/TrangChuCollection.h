//
//  TrangChuCollection.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/7/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPSPageMenu.h"
#import "MuaBan_TableViewController.h"
#import "Diendan_TableViewController.h"
#import "Daugia_TableViewController.h"
@interface TrangChuCollection : UICollectionViewController
{
    UITableView *tableView1;
     IBOutlet UIButton *btn_Chitiet;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_ShowTrangChu;
- (void)addDropShadow;
@property (strong, nonatomic) IBOutlet UICollectionView *trangChu;
@property (strong, nonatomic) NSArray* filteredTableData;
@property (nonatomic, assign) bool isFiltered;
@end
