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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // A URL que será carregada
    NSURL *url = [NSURL URLWithString:@"http://www.uol.com.br"];
    
    // Cria uma requisição web
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Carrega a página usando um request
    [self.web loadRequest:request];
}

- (IBAction)voltar:(UIBarButtonItem *)sender {
    // Testa se tem conteúdo para voltar
    if (self.web.canGoBack) {
        // manda o navegador voltar para a página anterior
        [self.web goBack];
    }
}

- (IBAction)avancar:(UIBarButtonItem *)sender {
    // Testa se tem conteúdo para avançar
    if(self.web.canGoForward)
        // Manda o navegador avançar para a próxima página
        [self.web goForward];
}

- (IBAction)reload:(UIBarButtonItem *)sender {
    [self.web reload];
    [self.spinner startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (IBAction)stop:(UIBarButtonItem *)sender {
    if(self.web.isLoading){
        [self.web stopLoading];
        [self.spinner stopAnimating];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
