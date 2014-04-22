//
//  AppDelegate.h
//  MonitorExterno
//
//  Created by Eduardo Lima on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) UIWindow *window;


//Representar um segundo monitor conectado via cabo
@property (strong, nonatomic) UIWindow *windowExterna;
@property (strong, nonatomic) UIScreen *screenExterna;

//Foto para exibir no monitor externo
@property (nonatomic, strong) UIImageView *foto;

@end
