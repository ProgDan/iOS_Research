//
//  AppDelegate.m
//  MonitorExterno
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Temos um segundo monitor?
    if ([[UIScreen screens] count] > 1) {
        // 0 - Tela Principal
        // 1 - Tela Externa
        
        // Salvando a referência da tela externa
        self.screenExterna = [[UIScreen screens] objectAtIndex:1];
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Monitor externo" message:@"Monitor externo reconhecido!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        // Permitir que o usuário escolha a resolução
        for (UIScreenMode *mode in self.screenExterna.availableModes) {
            // Adicionar um novo botão
            NSString *titulo = [NSString stringWithFormat:@"%.0f x %.0f", mode.size.width, mode.size.height];
            [alerta addButtonWithTitle:titulo];
        }
        [alerta show];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.screenExterna.currentMode = self.screenExterna.availableModes[buttonIndex];
    
    self.windowExterna = [[UIWindow alloc] initWithFrame:self.screenExterna.bounds];
    
    // Associando a nova janela no segundo monitor
    self.windowExterna.screen = self.screenExterna;
    
    // Adicionar uma foto
    self.foto = [[UIImageView alloc] initWithFrame:self.windowExterna.bounds];
    self.foto.backgroundColor = [UIColor blueColor];
    
    [self.windowExterna addSubview:self.foto];
    
    // Exibir a nova window
    [self.windowExterna makeKeyAndVisible];
}

@end
