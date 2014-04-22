//
//  GerenciadorCompras.h
//  ComprasNoAplicativo
//
//  Created by Fernando Dutra Pastor on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol GerenciadorComprasDelegate <NSObject>

@required

-(void)dadosProduto:(SKProduct*)produto;

-(void)compraOK:(SKPaymentTransaction*)transacao;

-(void)compraFalhou;

@end


@interface GerenciadorCompras : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>{
    
    SKProductsRequest *requisicaoProdutos;
    
}

@property(nonatomic, weak)id<GerenciadorComprasDelegate>delegate;

-(void)getProduto:(NSString*)produtoID delegate:(id<GerenciadorComprasDelegate>)aDelegate;

-(void)comprar:(SKProduct*)produto delegate:(id<GerenciadorComprasDelegate>)aDelegate;

//método que será chamado depois que a compra foi liberada. Obrigatoriamente devemos finalizar todas as transacoes que foram bem sucedidas.
-(void)finalizarCompra:(SKPaymentTransaction*)transacao;


@end
