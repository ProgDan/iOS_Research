//
//  AppDelegate.m
//  UIKitCustomizado
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(void) custumizarAparencia {
    // Customizar o bar buttom item
    
    // Para possibilitar a replicação da imagem usamos o método resizableImageWithCapInsets o UIEdgeInsets define a área que queremos replicar
    UIImage *imageBarButton = [[UIImage imageNamed:@"btn_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:imageBarButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    UIImage *imageBarButtonLand = [[UIImage imageNamed:@"btn_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:imageBarButtonLand forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    // Mudar a imagem de background do navbar
    UIImage *imageNavBar = [[UIImage imageNamed:@"navbar_44"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:imageNavBar forBarMetrics:UIBarMetricsDefault];

    UIImage *imageNavBarLand = [[UIImage imageNamed:@"navbar_32"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:imageNavBarLand forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Customizando textos
    
    // BarButton
    NSDictionary *dictBotao = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont fontWithName:@"Futura-CondensedMedium" size:15]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:dictBotao forState:UIControlStateNormal];
    
    // NavigationBar
    NSDictionary *dictBar = @{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont fontWithName:@"FuturaStd-BoldOblique" size:19]};
    [[UINavigationBar appearance] setTitleTextAttributes:dictBar];
    
    // Customizar o TabBar
    // Diretamente no StoryBoard
    
    // Customizando o Slider
    UIImage *minImagem = [[UIImage imageNamed:@"slider_minimum"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIImage *maxImagem = [[UIImage imageNamed:@"slider_maximum"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIImage *thumb = [UIImage imageNamed:@"corinthians"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImagem forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImagem forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumb forState:UIControlStateNormal];
    
    // SegmentedControl
    UIImage *segSelecionado = [[UIImage imageNamed:@"segcontrol_sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    UIImage *segNaoSelecionado = [[UIImage imageNamed:@"segcontrol_uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    UIImage *segSimNao = [[UIImage imageNamed:@"segcontrol_sel-uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    UIImage *segNaoSim = [[UIImage imageNamed:@"segcontrol_uns-sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    UIImage *segNaoNao = [[UIImage imageNamed:@"segcontrol_uns-uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    
    [[UISegmentedControl appearance] setBackgroundImage:segSelecionado forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segNaoSelecionado forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segSimNao forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segNaoSim forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segNaoNao forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self custumizarAparencia];
    // Override point for customization after application launch.
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
