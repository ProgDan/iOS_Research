//
//  ViewController.m
//  Web
//
//  Created by Daniel Arndt Alves on 2/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // A URL que será carregada
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    
    // Cria uma requisição web
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Carrega a página usando um request
    [self.web loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
