//
//  ViewController.m
//  OCThread
//
//  Created by macpro on 2017/12/8.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "GYOperation.h"
#import "GYBuyTickets.h"

typedef void(^GYblock)(void);

@interface ViewController ()

@property (nonatomic,copy) GYblock block;
@property (nonatomic,strong) dispatch_queue_t queuet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 方法一，需要start */
//    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
//    // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
//    [thread1 setThreadPriority:0.5];
//    [thread1 start];
//
//    /** 方法二，创建好之后自动启动 */
//    [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
//
//    /** 方法三，隐式创建，直接启动 */
//    [self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
//
//    // 当前线程
//    [NSThread currentThread];
//    NSLog(@"%@",[NSThread currentThread]);
  
    
    // 并发队列
//    [self serial];

//    [self groupCount];
//    [self gcdSemaphore];
    [self gcdSuspend];
    

}

#pragma mark - NSThread

#pragma mark - NSThread Lock

-(void)lock{
    GYBuyTickets *buy = [[GYBuyTickets alloc] init];
    [buy start];
//    dispatch_resume(_queuet);
}

#pragma mark - GCD

- (void)gcdSuspend {
    
    _queuet = dispatch_queue_create("COM.GY", DISPATCH_QUEUE_CONCURRENT);
    dispatch_suspend(_queuet);//暂时挂起未执行的队列
    dispatch_async(_queuet, ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"%d",i);
        }
    });

    [self requestNetWorkWithblock:^{
        [NSThread sleepForTimeInterval:5];
        dispatch_resume(_queuet);//恢复队列
    }];
}

- (void)gcdSemaphore {
    
   dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
   dispatch_queue_t queue = dispatch_queue_create("com.gy", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 1000; i++) {
    
        dispatch_async(queue, ^{
            //当信号量大于0时等待结束
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"semaphore:%d",i);
            //使信号量加1
            dispatch_semaphore_signal(semaphore);
        });
        
    }
    
}

- (void)gcdBarrier {
    dispatch_queue_t queue = dispatch_queue_create("gy.test.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步1:%@",[NSThread currentThread]);
        }
    });

    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步2:%@",[NSThread currentThread]);
        }
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"------------barrier------------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步3:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步4:%@",[NSThread currentThread]);
        }
    });
    
}

- (void)groupCount {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    [self requestNetWorkWithblock:^{
        dispatch_group_leave(group);
        NSLog(@"group1");
        
    }];
    
    [self requestNetWorkWithblock:^{
        dispatch_group_leave(group);
        NSLog(@"group2");
    }];
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"group end");
        
    });
}

- (void)group {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t concurrnet = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group,concurrnet, ^{
        [self requestNetWorkWithblock:^{
            NSLog(@"requestNetWork");
        }];
    });
    
    dispatch_group_async(group,concurrnet, ^{
        [self requestNetWorkWithblock:^{
            NSLog(@"requestNetWork");
        }];
    });
    
    dispatch_group_notify(group, concurrnet, ^{
        
        NSLog(@"group end");
        
    });
    
}

- (void)groupSerial {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t serialQueue = dispatch_queue_create("gy.test1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_group_async(group,serialQueue , ^{
        for (int i = 0; i < 3; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"group1:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group,serialQueue, ^{
        for (int i = 0; i < 3; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"group2:%@",[NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, serialQueue, ^{
        
        NSLog(@"group end");
        
    });
    
}

- (void)requestNetWorkWithblock:(void(^)(void))block {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [NSThread sleepForTimeInterval:1];
        
        block();
        
    });
    
}

- (void)concurrent{
    
    //并行
    dispatch_queue_t queue = dispatch_queue_create("gy.test.CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"start");
    //开辟新的线程
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"queue1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"queue2");
    });
    
    NSLog(@"end");
    
}

- (void)serial{
    
    //串行 会阻塞当前线程
    dispatch_queue_t queue = dispatch_queue_create("gy.test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"start");
    //开辟一个新的线程 但依然会阻塞当前线程
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"queue1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"queue2");
    });
    
    NSLog(@"end");

}

#pragma mark - NSOperationQueue

- (void)runOperationQueue{
    
     // NSOperationQueue
     
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     NSLog(@"start");
     GYOperation *operationA = [[GYOperation alloc] initWithName:@"GYOperationA"];
     GYOperation *operationB = [[GYOperation alloc] initWithName:@"GYOperationB"];
     GYOperation *operationC = [[GYOperation alloc] initWithName:@"GYOperationC"];
     GYOperation *operationD = [[GYOperation alloc] initWithName:@"GYOperationD"];
     
     //设置依赖关系
     [operationD addDependency:operationA];
     [operationA addDependency:operationB];
     [operationB addDependency:operationC];
     
     [queue addOperation:operationA];
     [queue addOperation:operationB];
     [queue addOperation:operationC];
     [queue addOperation:operationD];
     NSLog(@"end");
     
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     NSInvocationOperation *invocationQue = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
     //会阻塞当前线程  子线程或者主线程都会被阻塞
     //        [invocationQue start];
     [queue addOperation:invocationQue];
     NSLog(@"invocationEnd");
     
     });
     
     NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
     
     for (int i = 0; i < 3; i++) {
     NSLog(@"invocation");
     [NSThread sleepForTimeInterval:1];
     }
     
     }];
     [block addExecutionBlock:^{
     NSLog(@"block1");
     [NSThread sleepForTimeInterval:1];
     }];
     [block addExecutionBlock:^{
     NSLog(@"block2");
     [NSThread sleepForTimeInterval:1];
     }];
     [block addExecutionBlock:^{
     NSLog(@"block3");
     [NSThread sleepForTimeInterval:1];
     }];
     //同步阻塞
     [block start];
//     异步执行
//     [queue addOperation:block];

}

- (void)run {
    
    for (int i = 0; i < 3; i++) {
        NSLog(@"invocation");
        [NSThread sleepForTimeInterval:1];
    }
    
}

#pragma mark -
- (void)doSomething1:(NSObject *)object {
    // 传递过来的参数
    NSLog(@"%@",object);
    NSLog(@"%hhd",[NSThread isMultiThreaded]);
    NSLog(@"doSomething1：%@",[NSThread currentThread]);
}

- (void)doSomething2:(NSObject *)object {
    NSLog(@"%@",object);
    NSLog(@"doSomething2：%@",[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object {
    NSLog(@"%@",object);
    NSLog(@"doSomething3：%@",[NSThread currentThread]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
