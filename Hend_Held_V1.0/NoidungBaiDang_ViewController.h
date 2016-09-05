//
//  NoidungBaiDang_ViewController.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoidungBaiDang_ViewController : UIViewController{
    IBOutlet UILabel *lbl_Thread;
    IBOutlet UILabel *lbl_Tittle;
    IBOutlet UILabel *lbl_Username;
    IBOutlet UILabel *lbl_date;
    UIScrollView *myScrollView;
    IBOutlet UILabel *lbl_space;
    IBOutlet UIView *view1;
}
-(IBAction)MenuButton:(id)sender;
-(IBAction)CommentButton_event:(id)sender;


@end
