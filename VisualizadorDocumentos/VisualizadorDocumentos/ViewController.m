//
//  ViewController.m
//  VisualizadorDocumentos
//
//  Created by Eduardo Lima on 2/17/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//Objeto capaz de abrir documentos de extensões clássicas de edição de texto, slides e planilhas
@property (nonatomic, strong) UIDocumentInteractionController *docController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)abrirPDFClicado:(id)sender {
    
    //Localizando doc
    NSString *path = [[NSBundle mainBundle] pathForResource:@"exemplo" ofType:@"pdf"];
    
    //Criando uma URL a partir do path
    NSURL *urlArquivo = [NSURL fileURLWithPath:path];
    
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:urlArquivo];

    self.docController.delegate = self;
    
    //Apresentando o doc
    [self.docController presentPreviewAnimated:YES];
    
}

//Onde o doc será exibido
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller{
    
    return self;
}

@end
