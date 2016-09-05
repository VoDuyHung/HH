//
//  NoidungBaiDang_ViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "NoidungBaiDang_ViewController.h"
#import "DBManager.h"
#import <sqlite3.h>

@interface NoidungBaiDang_ViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation NoidungBaiDang_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set button for like,comment,share
    
    UIImage *imageFavorite = [UIImage imageNamed:@"THEODOIBAIVIET.png"];
    UIButton *favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteButton.bounds = CGRectMake(0, 0, 15, 15);
    [favoriteButton setImage:imageFavorite forState:UIControlStateNormal];
    [favoriteButton addTarget:self action:@selector(favoriteButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fvrButton= [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
    
    //menu button
    UIImage *imageComment = [UIImage imageNamed:@"COMMENT.png"];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.bounds = CGRectMake(0, 0, 15, 15);
    [commentButton setImage:imageComment forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(CommentButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cmtButton= [[UIBarButtonItem alloc] initWithCustomView:commentButton];
    
    UIImage *imageShare = [UIImage imageNamed:@"CHIASE.png"];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.bounds = CGRectMake(0, 0, 15, 15);
    [shareButton setImage:imageShare forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(ShareButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shrButton= [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    NSArray *arrayButton= [[NSArray alloc] initWithObjects:shrButton,cmtButton,fvrButton, nil];
    self.navigationItem.rightBarButtonItems=arrayButton;
    
    
    
    //end code
    //set title, thread, name, date for post
    
    NSString *contentPost = [[NSUserDefaults standardUserDefaults] objectForKey:@"contentof_Post"];
    //thread
    NSString *tittle_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    lbl_Thread.text = tittle_key;
    self.navigationItem.title=tittle_key;
    
    //tittle
    NSString *tittlePost_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"TitleOf_Post"];
    lbl_Tittle.text=tittlePost_key;
    NSLog(@"Tieude:%@",tittlePost_key);
    
    //name
    NSString *namePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserOf_Post"];
    lbl_Username.text=namePost;
    NSLog(@"hoten:%@",namePost);
    
    //date
    NSString *dateTimePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"DateOf_Post"];
    lbl_date.text=dateTimePost;
    NSLog(@"ngatythang:%@",dateTimePost);
    
    lbl_space.text=@"-----------------------------------------------";
    NSString *PostId = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    NSLog(@"Idpost:%@",PostId);
    
    UITextView *textView = [[UITextView alloc] init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 172, 306, 380)];
    textView.editable=NO;
    
    [self.view addSubview:textView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentPost dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    textView.attributedText = attributedString;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"Favorite.sqlite"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShareButton_event:(id)sender{
    
    //get values url from Danh
    
    NSString *url_post = [[NSUserDefaults standardUserDefaults] objectForKey:@"url_Share"];
    //Share social network
    NSString *texttoshare = @"";
    NSURL *myWebsite = [NSURL URLWithString:url_post];
    
    //  UIImage *imagetoshare = [UIImage imageNamed:@"beck.png"];
    
    NSArray *activityItems = @[texttoshare,myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    activityVC.excludedActivityTypes =@[UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
}

-(void)CommentButton_event:(id)sender{
    [self performSegueWithIdentifier:@"comment" sender:self];
    
}
-(void)favoriteButton_event:(id)sender{
    //end code
    //set title, thread, name, date for post
    
    NSString *contentPost = [[NSUserDefaults standardUserDefaults] objectForKey:@"contentof_Post"];
    //  NSLog(@"Noidung:%@",contentPost);
    
    //tittle
    NSString *tittlePost_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"TitleOf_Post"];
    lbl_Tittle.text=tittlePost_key;
    
    //name
    NSString *namePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserOf_Post"];
    lbl_Username.text=namePost;
    
    //date
    NSString *dateTimePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"DateOf_Post"];
    lbl_date.text=dateTimePost;
    
    lbl_space.text=@"-----------------------------------------------";
    NSString *PostId = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    NSString *Post_Detail = [[NSUserDefaults standardUserDefaults] objectForKey:@"ContentOf_Post"];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO FV_TABLE VALUES('%@','%@','%@','%@','%@','%@')",PostId,tittlePost_key,contentPost,Post_Detail,dateTimePost,namePost];
    [self.dbManager executeQuery:query];
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        // Showing status
        NSLog(@"Add infor successed!");
    }
    else{
        // Showing status
        NSLog(@"Add infor failed!");
        NSLog(@"Could not execute the query.");
    }
    
}



@end
