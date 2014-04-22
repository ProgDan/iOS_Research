//
//  GerenciadorCompras.m
//  ComprasNoAplicativo
//
//  Created by Fernando Dutra Pastor on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GerenciadorCompras.h"

@implementation GerenciadorCompras

@synthesize delegate;

-(id)init
{
    self = [super init];
    
    if (self != nil) 
    {
        //quando fizermos um pedido de compra, teremos que setar quem vai ser o "delegate" que vai atualizações do status da compra. No caso ele chama de observer.
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}


-(void)getProduto:(NSString*)produtoID delegate:(id<GerenciadorComprasDelegate>)aDelegate
{
    //criar uma requisicao para o produto pedido, podemos pedir mais do que um produto
    requisicaoProdutos = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:produtoID]];
    
    requisicaoProdutos.delegate = self;
    
    //inicia a busca pelos dados do produto
    [requisicaoProdutos start];
    
    delegate = aDelegate;
}

//metodo acionado quando chega o resultado da busca por dados dos produtos
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Falhou busca de: %@", response.invalidProductIdentifiers);
    
    if (response.products.count > 0) 
    {
        [delegate dadosProduto:[response.products objectAtIndex:0]];
    }
}

-(void)comprar:(SKProduct*)produto delegate:(id<GerenciadorComprasDelegate>)aDelegate
{
    SKPayment *pagamento = [SKPayment paymentWithProduct:produto];
    
    //vamos adicionar esse produto na fila, agora o TransactionObserver tratará esse pedido
    [[SKPaymentQueue defaultQueue] addPayment:pagamento];
    
    delegate = aDelegate;
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *pagamento in transactions) 
    {
        if (pagamento.transactionState == SKPaymentTransactionStatePurchased) 
        {
            //compra bem sucedida, devemos liberar o conteudo comprado. Informamos para o VC que está tudo ok
            //retornamos a transacao para o VC, para que ele possa finalizar a compra depois que o usuario já obteve seu produto
            [delegate compraOK:pagamento];
        }
        else if (pagamento.transactionState == SKPaymentTransactionStateFailed)
        {
            //compra não deu certo... bem provável que seja por falta de saldo
            [delegate compraFalhou];
        }
        else if (pagamento.transactionState == SKPaymentTransactionStateRestored)
        {
            //a compra já estava OK, mas não finalizamos ela corretamente, devemos tentar pedir para o usuario baixar o produto novamente
            [delegate compraOK:pagamento];
        }
    }
}

//método que será chamado depois que a compra foi liberada. Obrigatoriamente devemos finalizar todas as transacoes que foram bem sucedidas.
-(void)finalizarCompra:(SKPaymentTransaction*)transacao
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transacao];
}

@end
