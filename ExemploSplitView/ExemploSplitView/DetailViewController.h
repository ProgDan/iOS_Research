//
//  DetailViewController.h
//  ExemploSplitView
//
//  Created by Daniel Arndt Alves on 3/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@end