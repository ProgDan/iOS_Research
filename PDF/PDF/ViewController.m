//
//  ViewController.m
//  PDF
//
//  Created by Daniel Arndt Alves on 2/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIDocumentInteractionController *docController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)abrirPDF:(UIButton *)sender {
    // Carrega o path para o arquivo
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iPhone intro" ofType:@"pdf"];
    
    // Cria a URL para abertura do arquivo
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // Cria o document controller
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    
    self.docController.delegate = self;
    
    // isso serve para o iPhone sugerir mais aplicações para abrir o seu arquivo
    self.docController.UTI = @"com.adobe.pdf";
    
    [self.docController presentPreviewAnimated:YES];
}
- (IBAction)abrirPDFCustomizado:(UIButton *)sender {
    // Carrega o path para o arquivo
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iPhone intro" ofType:@"pdf"];
    
    // Cria a URL para abertura do arquivo
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // Cria o document controller
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    
    self.docController.delegate = self;
    
    // isso serve para o iPhone sugerir mais aplicações para abrir o seu arquivo
    self.docController.UTI = @"com.adobe.pdf";
    
    [self.docController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
}

// Este método informa em qual viewController o documento será visualizado
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
