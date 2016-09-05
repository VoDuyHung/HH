//
//  Custome_.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/5/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Custome_.h"
#import "ViewController.h"
#import "DBManager.h"
#import "Danhmuc_.h"
#import "TableViewController.h"
@interface Custome_ (){
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *username;
    NSString *node_id;
    NSString *title;
    NSString *thread_id;
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;

@end

@implementation Custome_

- (void)viewDidLoad {
    [super viewDidLoad];
    //code hien thi tin tuc
    //khai bao tableview
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Danhmuc_ class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([Danhmuc_ class])];
    title = @"title";
    username = @"thumbnail_cache_waindigo";
    myObject = [[NSMutableArray alloc] init];
    // goi bien USER_NAME & HASH_KEY  tu ben class ViewController;
    //su dung SQLite
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"USERDB.sqlite"];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM USERTABLE"];
    
    // Get the results.
    if (self.arrResult != nil) {
        self.arrResult = nil;
    }
   self.arrResult = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSString *hashKey = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"HASHKEY"]];
    NSString *useName = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"USERNAME"]];
    
    
    //truyen username va hashkey vao trong chuoi json
    NSString *urlString = [NSString  stringWithFormat: @"http://dev.handheld.vn/api.php?action=getThreads&hash=%@:%@&node_id=95&limit=100&order_by=post_date", useName , hashKey];
    NSURL*url = [NSURL URLWithString:urlString];
    
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    //trả về giá trị json
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    //lap theo gia tri cua threads
    NSArray * responseArr = json[@"threads"];
    
    for(NSDictionary * dict in responseArr)
    {
        //lay gia tri
        NSString *referanceArray = [dict valueForKey:@"title"];
        NSString *periodArray =[dict valueForKey:@"thumbnail_cache_waindigo"];
        NSString *searchedString = periodArray;
        //cat chuỗi để lấy ra link hình ảnh
        NSArray *myWords = [searchedString componentsSeparatedByCharactersInSet:
                            [NSCharacterSet characterSetWithCharactersInString:@"\""]
                            ];
        NSMutableArray * manghttp=[[NSMutableArray alloc] initWithArray:myWords];
        //lấy chuỗi link hình trong mảng
        NSString *hinhanh = [manghttp objectAtIndex:3];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      referanceArray,title,
                      hinhanh,username,
                      nil];
        [myObject addObject:dictionary];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Danhmuc_ *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Danhmuc_ class]) forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
         
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:username]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    cell.image1.image=img;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0f;
}


@end
