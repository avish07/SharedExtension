//
//  ViewController.h
//  SE
//
//  Created by gh on 6/1/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSUserDefaults *userDefaults;
    NSMutableArray *urlArr;
    __weak IBOutlet UITableView *tblObj;
}
-(IBAction)getSharedData:(id)sender;

@end

