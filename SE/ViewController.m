//
//  ViewController.m
//  SE
//
//  Created by gh on 6/1/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
//    userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Guesthouser"];
//    urlArr = [[NSMutableArray alloc] init];
//    [urlArr addObject: [userDefaults objectForKey:@"SharedExtension"]? [NSMutableArray arrayWithObjects: [userDefaults objectForKey:@"SharedExtension"], nil ]: @"1"];
    [super viewWillAppear:animated];
}

-(IBAction)getSharedData:(id)sender{
    userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Guesthouser"];
    urlArr = [[NSMutableArray alloc] init];
    NSLog(@":%@", [userDefaults valueForKey:@"SharedExtension"]);
    if ( [userDefaults valueForKey:@"SharedExtension"]) {
        urlArr = [userDefaults valueForKey:@"SharedExtension"];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [tblObj setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
            
            [tblObj setDataSource:self];
            [tblObj setDelegate:self];
            [tblObj reloadData];
        });
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Go to Photos App" message:@"post image using ShareExtension" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:true completion:nil];
        }];
    
        [alertController addAction:action];
        [self presentViewController:alertController animated:true completion:nil];
    }
}


#pragma mark - UITableview Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return urlArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ShareDataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *txtLbl = (UILabel *)[cell.contentView viewWithTag:1];
    [txtLbl setText:urlArr[indexPath.row][@"Text"]];
    UILabel *urlLbl = (UILabel *)[cell.contentView viewWithTag:2];
    [urlLbl setText:urlArr[indexPath.row][@"URL"]];
    return cell;
}


@end
