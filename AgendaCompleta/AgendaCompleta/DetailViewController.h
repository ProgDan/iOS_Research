//
//  DetailViewController.h
//  AgendaCompleta
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *dicItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
