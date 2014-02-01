//
//  AppDelegate.m
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "AppDelegate.h"

// Importação das definições da classe Pessoa
#import "Pessoa.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Declarando a classe Pessoa
    Pessoa* pessoa1;
    
    // Instanciando o objeto da classe Pessoa
    pessoa1 = [[Pessoa alloc] init];
    
    // Chamando um método
    [pessoa1 falar];
    [pessoa1 falarTexto:@"Olá!"];
    
    // Pegando um valor de retorno
    int idadePessoa = [pessoa1 getIdade];
    NSLog(@"A Pessoa tem %d anos.", idadePessoa);
    
    [pessoa1 andarRua1:@"Rua Amauri" eRua2:@"Av. Faria Lima"];
    
    // Atribuindo o nome da pessoa (Property)
    pessoa1.nome = @"Eduardo da Silva";
    pessoa1.altura = 1.75;
    
    // Getter e Setter automáticos da Property
    [pessoa1 setNome:@"José Souza"];
    [pessoa1 nome];
    
    [pessoa1 falar];
    
    NSLog(@"O %@ tem %f de altura", pessoa1.nome, pessoa1.altura);
    
    // Outra pessoa
    Pessoa* pessoa2 = [[Pessoa alloc] initWithNome:@"Joaquim Alves" withIdade:16];
    [pessoa2 falar];
    
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
