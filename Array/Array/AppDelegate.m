//
//  AppDelegate.m
//  Array
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "AppDelegate.h"
#import "Pessoa.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Array
    NSArray* vetor1 = [[NSArray alloc] initWithObjects:@"Eduardo",@"Rafael",@"Maria",@"João", nil];
    
    NSLog(@"vetor: %@", vetor1);
    
    // número de elementos do vetor
    NSLog(@"quantidade de elementos: %d", vetor1.count);
    
    // pegando o elemento 2
    NSString* objeto2 = [vetor1 objectAtIndex:2];
    NSLog(@"item 2: %@", objeto2);
    
    // Array dinâmico
    NSMutableArray* vetor2 = [[NSMutableArray alloc] initWithArray:vetor1];
    
    // Pessoa
    Pessoa* pessoa1 = [[Pessoa alloc] initWithNome:@"Teste" withIdade:20];
    
    // Adicionando no vetor
    [vetor2 addObject:pessoa1];     // Não é comum misturar os tipos no vetor!
    
    [vetor2 addObject:@"Luiza"];
    
    NSLog(@"Vetor2: %@",vetor2);
    
    // Remover um objeto
    [vetor2 removeObjectAtIndex:1];
    
    NSLog(@"vetor 2 removido: %@", vetor2);
    
    // Trabalhando com números
    /* [vetor2 addObject:10];       ERRO! Não conseguimos usar objetos primitivos no vetor!  */
    NSNumber* numero1 = [[NSNumber alloc] initWithInt:10];
    NSNumber* numero2 = [[NSNumber alloc] initWithFloat:10.8];
    [vetor2 addObject:numero2];
    [vetor2 addObject:numero1];
    
    NSLog(@"Vetor com números %@", vetor2);
    
    int num = [[vetor2 lastObject] intValue];
    NSLog(@"numero: %d", num);
    
    // Identificando o tipo do elemento
    if([[vetor2 objectAtIndex:3]isKindOfClass:[NSString class]]){
        NSLog(@"o objeto 3 é do tipo string");
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

@end
