//
//  ShareViewController.m
//  ShareExtension
//
//  Created by gh on 6/1/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "ShareViewController.h"
@import MobileCoreServices;

static NSString *const appGroupId = @"group.Guesthouser";

@interface ShareViewController (){
    NSArray *arrCategory;
   
}
@property SLComposeSheetConfigurationItem * item;
@property (strong, nonatomic) NSArray * array;

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    NSInteger txtLength = [[self.contentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length];
    NSInteger charRemainig = 5 - txtLength;
    
    if (charRemainig > 0)
        self.charactersRemaining = [NSNumber numberWithInteger:charRemainig];
    else
        self.charactersRemaining  = @0;
   
    if (charRemainig <= 0) {
        return true;
    }
    
    return false;
}

-(void)viewDidLoad{

    self.title = @"Wish List";
    self.placeholder = @"Write Something";
    self.charactersRemaining = @5;
    userDefaults = [[NSUserDefaults alloc] initWithSuiteName:appGroupId];
    
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    
    inputItem = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider = [inputItem.userInfo valueForKey:NSExtensionItemAttachmentsKey][0];
    
    //(__bridge NSString *)kUTTypeURL
    if ([itemProvider hasItemConformingToTypeIdentifier:@"public.image"]) {
        
        [itemProvider loadItemForTypeIdentifier:@"public.image" options:nil completionHandler:^(id<NSSecureCoding>   item, NSError *  error) {
            
            if (error) {
                NSLog(@"error occuured");
            }
            else
            {
                NSMutableArray *arrSites;
                
                if ([userDefaults valueForKey:@"SharedExtension"]) {
                    arrSites = [[NSMutableArray alloc] init];
                    arrSites = [[userDefaults valueForKey:@"SharedExtension"] mutableCopy];
                }
                else
                    arrSites = [[NSMutableArray alloc] init];
                
                NSDictionary *dict = @{@"Text": self.contentText , @"URL": [(NSURL *)item absoluteString]};
                [arrSites addObject:[dict mutableCopy]];
               
                [userDefaults setObject:arrSites forKey:@"SharedExtension"];
                [userDefaults synchronize];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Posted successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
                    
                    [UIView animateWithDuration:0.01 animations:^{
                        
                        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
                    } completion:^(BOOL finished) {
                         [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
                    }];
                }];
                
                [alertController addAction:action];
                [self presentViewController:alertController animated:true completion:nil];
            }
        }];
        
    }
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
   
        ConfigViewController * configTable = [[ConfigViewController alloc]init];
        configTable.size = self.preferredContentSize;
        
        self.array = @[@"Wish List", @"Favorite"];
        configTable.optionsArr = [self.array mutableCopy];
        configTable.delegate = self;
        self.item = [[SLComposeSheetConfigurationItem alloc]init];
        self.item.title = @"Option";
        
        self.item = [[SLComposeSheetConfigurationItem alloc]init];
        self.item.title = @"List of Titles";
        self.item.value = @"Tap";
        
        __weak typeof(self) weakSelf = self;
        weakSelf.item.tapHandler = ^{
            [weakSelf pushConfigurationViewController:configTable];
        };
        
        return @[self.item];
}

-(void)didSelectItemAtIndexPath:(NSIndexPath *)index{
    
    self.title = index.row == 0?@"Wish List": @"Favorite";
    [self popConfigurationViewController];
}



@end
