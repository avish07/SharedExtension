//
//  ConfigViewController.h
//  SE
//
//  Created by gh on 6/2/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfigTableProtocol <NSObject>

@optional
-(void)didSelectItemAtIndexPath:(NSIndexPath *)index;
@end


@interface ConfigViewController : UITableViewController
@property CGSize size;
@property(strong, nonatomic) NSMutableArray *optionsArr;
@property(nonatomic, assign) id<ConfigTableProtocol> delegate;

@end
