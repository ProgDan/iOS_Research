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
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISearchBar *busca;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self abreSite:@"http://www.uol.com.br"];
}

-(void) abreSite:(NSString *)urlString{
    
    if ([urlString rangeOfString:@"http://"].location == NSNotFound) {
        
        // Formato elegante
//        urlString = [NSString stringWithFormat:@"http://%@", urlString];
        
        // Formato alternativo
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    
    // A URL que será carregada
    NSURL *url = [NSURL URLWithString:urlString];
    
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

- (IBAction)navegaBusca:(UISegmentedControl *)sender {
    self.busca.text = nil;
    
    if (self.segment.selectedSegmentIndex == 0) {
        self.busca.placeholder = @"Endereço";
    }
    else {
        self.busca.placeholder = @"Google";
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // Opção de Navegar
    if(self.segment.selectedSegmentIndex == 0){
        [self abreSite:searchBar.text];
    }
    // Opção de Buscar
    else {
        NSString *urlGoogle = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",searchBar.text];
        
        // Normalização da String para a Web
        urlGoogle = [urlGoogle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self abreSite:urlGoogle];
    }
    
    [searchBar resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)navegabusca:(UISegmentedControl *)sender {
}
@end
