//
//  ChatViewController.h
//  Chat
//
//  Created by Daniel Arndt Alves on 3/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MultipeerConnectivity;

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate>

// Parâmetro da primeira tela
@property (strong, nonatomic) NSString *apelido;

@end
