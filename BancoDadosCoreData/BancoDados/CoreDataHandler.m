//
//  CoreDataHandler.m
//  BancoDados
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "CoreDataHandler.h"

@implementation CoreDataHandler

// Retem a única instância do objeto
static CoreDataHandler *_shared = nil;

+(CoreDataHandler*)shared
{
    @synchronized([CoreDataHandler class]){
        if (!_shared) {
            _shared = [CoreDataHandler new];
            [_shared abrirBancoDados];
        }
        return _shared;
    }
}

-(void) abrirBancoDados
{
    // Documents/nome do arquivo model do Core Data
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/Livraria"];
    
    // Uma referência ao arquivo salvo em disco
    UIManagedDocument *documento = [[UIManagedDocument alloc] initWithFileURL:[NSURL fileURLWithPath:path]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // O arquivo não existe
        [documento saveToURL:documento.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Managed document criado!");
                
                self.contexto = documento.managedObjectContext;
                
                // Notifica que o banco está aberto
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CoreDataAbriuBanco" object:nil userInfo:nil];
            }
        }];
    }
    else if (documento.documentState == UIDocumentStateClosed){
        // O arquivo está fechado
        [documento openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Managed document aberto!");
                
                self.contexto = documento.managedObjectContext;
                
                // Notifica que o banco está aberto
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CoreDataAbriuBanco" object:nil userInfo:nil];
            }
        }];
    }
    else {
        // O arquivo já está aberto
        self.contexto = documento.managedObjectContext;
        
        // Notifica que o banco está aberto
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CoreDataAbriuBanco" object:nil userInfo:nil];
    }
}

#pragma mark Livro

-(void)inserirNovoLivro:(NSDictionary*)infoLivro
{
    // Criando o objeto (alloc/init) e ao mesmo tempo inserindo um novo registro na tabela
    Livro *novoLivro = [NSEntityDescription insertNewObjectForEntityForName:@"Livro" inManagedObjectContext:self.contexto];
    
    // Salvando informações que recebemos da ViewController
    novoLivro.titulo = infoLivro[@"titulo"];
    novoLivro.autor = infoLivro[@"autor"];
    novoLivro.preco = [NSNumber numberWithFloat:[infoLivro[@"preco"] floatValue]];
    novoLivro.ano = [NSNumber numberWithInt:[infoLivro[@"ano"] intValue]];
    
    NSError *erroBancoDados;
    
    if(![self.contexto save:&erroBancoDados]){
        NSLog(@"Erro na inserção %@", erroBancoDados.localizedFailureReason);
    }
    else {
        NSLog(@"Livro salvo com sucesso");
    }
}

-(NSArray*)buscarTodosLivros
{
    // Fetch
    NSFetchRequest *requisicao = [NSFetchRequest fetchRequestWithEntityName:@"Livro"];
    requisicao.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"titulo" ascending:YES]];
    
    NSFetchedResultsController *buscaController = [[NSFetchedResultsController alloc] initWithFetchRequest:requisicao managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:nil];
    
    NSError *erroBusca;
    if (![buscaController performFetch:&erroBusca]) {
        NSLog(@"Erro ao efetuar a busca: %@", erroBusca.localizedFailureReason);
    }
    else {
        return buscaController.fetchedObjects;
    }
    return nil;
}

-(void)removerLivro:(Livro*)livro
{
    NSError *erroRemover;
    
    [self.contexto deleteObject:livro];
    
    if (![self.contexto save:&erroRemover]) {
        NSLog(@"Erro ao remover o livro: %@", erroRemover.localizedDescription);
    }
    else {
        NSLog(@"Livro removido com sucesso!");
    }
}

@end
