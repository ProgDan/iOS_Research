//
//  ComprasNoAplicativoViewController.m
//  ComprasNoAplicativo
//
//  Created by Fernando Dutra Pastor on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComprasNoAplicativoViewController.h"

@implementation ComprasNoAplicativoViewController


-(IBAction)infoProduto:(id)sender
{
    //pedir as informacoes do produto a ser comprado
    [minhaLoja getProduto:@"com.eduardo.cloud.pacoteDeMoedas" delegate:self];
}

//metodo acionado quando chegam os dados do produto
-(void)dadosProduto:(SKProduct *)produto
{
    NSLog(@"Dados: %@ - %@", produto.localizedTitle, produto.localizedDescription);
    
    produtoASerComprado = produto;
}

-(IBAction)comprarProduto:(id)sender
{
    [minhaLoja comprar:produtoASerComprado delegate:self];
}

//metodo acionado quando a compra falha
-(void)compraFalhou
{
    NSLog(@"Erro ao efetuar a compra.");
}

//metodo acionado quando a compra é bem sucedida
-(void)compraOK:(SKPaymentTransaction *)transacao
{
    NSLog(@"Compra efetuada com sucesso. Pode fazer o download do pacote de moedas");
    
    //é nesse momento que efetuamos o download do produto ou qualquer outro tipo de liberação que tenha a ver com algum controle nosso
    
    
    //AO FINAL DO DOWNLOAD DO PRODUTO DEVEMOS FINALIZAR A COMPRA
    [minhaLoja finalizarCompra:transacao];
    
    //caso de erro no download ou qualquer outro problema que o usuario não efetue o download nesse momento, o status da transacao vai ficar pendente, até finalizar corretamente
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
