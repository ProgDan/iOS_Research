//
//  CoreDataHandler.h
//  BancoDados
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Livro.h"

// Criando um objeto para lidar com as requisições ao banco de dados
@interface CoreDataHandler : NSObject

// Singleton
// Uma classe que terá apenas uma única instância
+(CoreDataHandler*)shared;

-(void) abrirBancoDados;

// Contexto do Banco de Dados aberto
@property (strong, nonatomic) NSManagedObjectContext *contexto;

// Métodos para manipulação do modelo livro
-(void)inserirNovoLivro:(NSDictionary*)infoLivro;
-(NSArray*)buscarTodosLivros;
-(void)removerLivro:(Livro*)livro;

@end
