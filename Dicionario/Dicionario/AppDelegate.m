//
//  AppDelegate.m
//  Dicionario
//
//  Created by Daniel Arndt Alves on 2/2/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Criando um NSDictionary
    NSDictionary* dicionarioFixo = [[NSDictionary alloc]initWithObjects:@[@"valor1",@"valor2"] forKeys:@[@"chave1",@"chave2"]];
    NSLog(@"dicionario fixo: %@", dicionarioFixo);
    
    // acessando um elemento
    NSString* valorDaChave1 = [dicionarioFixo objectForKey:@"chave1"];
    NSLog(@"valor da chave 1: %@", valorDaChave1);
    
    // Dicionário mutável
    NSMutableDictionary* dicionario = [[NSMutableDictionary alloc]init];
    
    // inserindo chava valor
    [dicionario setObject:@"Andre" forKey:@"nome"];
    [dicionario setObject:@"Rua Amauri" forKey:@"endereco"];
    [dicionario setObject:[NSNumber numberWithFloat:1.68] forKey:@"altura"];

    NSLog(@"dicionario: %@", dicionario);

    // removendo um objeto do dicionário
    [dicionario removeObjectForKey:@"endereco"];
    
    NSLog(@"dicionario: %@", dicionario);
    
    
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

@end
