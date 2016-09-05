//
//  NoiDungBinhLuan_ViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/13/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "NoiDungBinhLuan_ViewController.h"

@interface NoiDungBinhLuan_ViewController ()

@end

@implementation NoiDungBinhLuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *contentPost = [[NSUserDefaults standardUserDefaults] objectForKey:@"chitiet_binhluan"];
    NSString *strForWebView = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-family: \"%@\"; font-size: %@;height: auto; }\n"
                               "img{max-width:100%%;height:auto !important;width:auto !important;}</style> \n"
                               "</head> \n"
                               "<body>%@</body> \n"
                               "</html>", @"helvetica", [NSNumber numberWithInt:50], contentPost];
    [loadcomment loadHTMLString:strForWebView baseURL:nil];
    [loadcomment setScalesPageToFit:YES];
    loadcomment.autoresizesSubviews = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
