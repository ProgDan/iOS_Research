//
//  ViewController.m
//  Navegador
//
//  Created by Daniel Arndt Alves on 2/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segNavegacao;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self abrePaginaComUrl:@"http://www.google.com.br"];
}

-(void)abrePaginaComUrl:(NSString *) strUrl {
    
    if ([strUrl rangeOfString:@"http://"].location != 0) {
        strUrl = [@"http://" stringByAppendingString:strUrl];
    }
    
    // cria uma url com a string do endereço do site
    NSURL *url = [NSURL URLWithString:strUrl];
    
    // cria uma recquisição we usando uma URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // carrega um request na webview
    [self.web loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voltar:(UIBarButtonItem *)sender {
    if (self.web.canGoBack) {
        [self.web goBack];
    }
}

- (IBAction)avancar:(UIBarButtonItem *)sender {
    if (self.web.canGoForward) {
        [self.web goForward];
    }
}

- (IBAction)parar:(UIBarButtonItem *)sender {
    if(self.web.isLoading){
        [self.web stopLoading];
    }
}

- (IBAction)recarregar:(UIBarButtonItem *)sender {
    [self.web reload];
}

- (IBAction)mudaNavegacao:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex) // navegar
    {
        // limpa a caixa de texto da searchBar
        self.search.text = @"";
        // define um placeholder para ela
        self.search.placeholder = @"http://";
    }
    else  // buscar
    {
        // limpa a caixa de texto da searchBar
        self.search.text = @"";
        // define um placeholder para ela
        self.search.placeholder = @"Google";
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.segNavegacao.selectedSegmentIndex) // Navegação
    {
        [self abrePaginaComUrl:searchBar.text];
    }
    else // Busca
    {
        NSString *strUrl = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",searchBar.text];
        [self abrePaginaComUrl:strUrl];
    }
    [searchBar resignFirstResponder];
}

@end
