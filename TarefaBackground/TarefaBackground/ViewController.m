//
//  ViewController.m
//  TarefaBackground
//
//  Created by Eduardo Lima on 4/6/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)iniciarProcessoClicado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //[self.tabela reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)iniciarProcessoClicado:(id)sender {
    
    //Iniciar uma tarefa em segundo plano
    //Solicitar uma autorização pro iOS para rodar por um tempo (+- 10 min)
    //Handler - executado quando o tempo da tarefa acabar
    UIBackgroundTaskIdentifier taskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
       
        //O que quero que aconteça quando o tempo acabar
        //...
        
        //Encerrar a tarefa
        //Não podemos esquecer de fazer esse passo, pq senão o app corre o risco de ser encerrado pelo iOS
        [[UIApplication sharedApplication] endBackgroundTask:taskID];
        
    }];
    
    //COMEÇO - TAREFA EM SEGUNDO PLANO
    //Disparar uma nova fila em outra thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        //Agora o processo acontece fora da main thread
        
        //Atividade demorada
        for (int i = 0; i < 2000; i++) {
            NSLog(@"Contando %d", i);
        }
        
        //Se precisar alterar um componente visual, voltamos para a mainthread
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.tabela reloadData];
            
            [[[UIAlertView alloc] initWithTitle:nil message:@"Acabou contagem" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles:nil] show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TAREFAACABOU" object:nil];
        });
        
        
        //Encerrar a tarefa
        [[UIApplication sharedApplication] endBackgroundTask:taskID];
    
        //FIM - TAREFA EM SEGUNDO PLANO
    });
    
    
    
    
    
    
    
    
}










@end
