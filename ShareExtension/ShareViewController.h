//
//  ShareViewController.h
//  ShareExtension
//
//  Created by gh on 6/1/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "ConfigViewController.h"

@interface ShareViewController : SLComposeServiceViewController<ConfigTableProtocol>{
    NSUserDefaults *userDefaults;
    NSExtensionItem *inputItem;
}

@end
