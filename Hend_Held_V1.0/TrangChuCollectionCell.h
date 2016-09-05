//
//  TrangChuCollectionCell.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/7/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrangChuCollectionCell : UICollectionViewCell{
    IBOutlet UIActivityIndicatorView *_activityIndicator;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageTrangChu;
@property (weak, nonatomic) IBOutlet UILabel *labelTrangChu;
@property (weak, nonatomic) IBOutlet UIWebView *img_load;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userpost;
@property (weak, nonatomic) IBOutlet UILabel *lbl_datepost;

@property (weak, nonatomic) IBOutlet UILabel *lbl_LageSizeTittle;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;


@end
