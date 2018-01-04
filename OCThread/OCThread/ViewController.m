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

#define queueIdendifer "com.gy.test"

typedef void(^GYblock)(void);

__weak NSString *string__weak = nil;
@interface ViewController ()

@property (nonatomic,copy) GYblock block;
@property (nonatomic,strong) dispatch_queue_t queuet;
@property (nonatomic,strong) NSCondition *condition;
@property (nonatomic,strong) UIView *view1;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _condition = [[NSCondition alloc] init];
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
//    [self group];

//    NSURL *directoryURL; // assume this is set to a directory
//    int const fd = open([[directoryURL path] fileSystemRepresentation], O_EVTONLY);
//    if (fd < 0) {
//        char buffer[80];
//        strerror_r(errno, buffer, sizeof(buffer));
//        NSLog(@"Unable to open \"%@\": %s (%d)", [directoryURL path], buffer, errno);
//        return;
//    }
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd,
//                                                      DISPATCH_VNODE_WRITE | DISPATCH_VNODE_DELETE, DISPATCH_TARGET_QUEUE_DEFAULT);
//    dispatch_source_set_event_handler(source, ^(){
//        unsigned long const data = dispatch_source_get_data(source);
//        if (data & DISPATCH_VNODE_WRITE) {
//            NSLog(@"The directory changed.");
//        }
//        if (data & DISPATCH_VNODE_DELETE) {
//            NSLog(@"The directory has been deleted.");
//        }
//    });
//    dispatch_source_set_cancel_handler(source, ^(){
//        close(fd);
//    });
//    dispatch_resume(source);
 
//    [self deadLockCase1];
    
    self.view1 = ({
        [UIView new];
//        [UIColor redColor];
        
    });
    self.view1.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:self.view1];
    NSString *str = [NSString stringWithFormat:@"zhuguangyang"];
    string__weak = str;
    NSLog(@"%@",string__weak);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",string__weak);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",string__weak);
}
#pragma mark - deadlock

- (void)deadLockCase1 {
    NSLog(@"1");
    //主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase2 {
    NSLog(@"1");
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create(queueIdendifer, DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase4 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        //将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    //死循环
    while (1) {
        //
    }
}
//dispatch_queue_set_specific和dispatch_get_specific 可通过标记检测是否是同一个队列来避免死锁
#pragma mark - NSThread

#pragma mark - NSThread Lock

-(void)lock{
    GYBuyTickets *buy = [[GYBuyTickets alloc] init];
    [buy start];
//    dispatch_resume(_queuet);
}

#pragma mark - GCD

- (void)gcdSourceTimer {
 
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    
    //    dispatch_time_t start;
    dispatch_source_set_timer(source, dispatch_walltime(NULL, 0),1 * NSEC_PER_SEC ,0);
    __block int i = 666;
    dispatch_source_set_event_handler(source, ^(){
        NSLog(@"%@",source);
        
        NSLog(@"Time flies%d",i);
    });
    dispatch_resume(source);
    NSLog(@"start");
    
}

- (void)gcdblockCancle {
    
    dispatch_queue_t cocurrentQueue = dispatch_queue_create(queueIdendifer, DISPATCH_QUEUE_SERIAL);
    NSLog(@"start");
    dispatch_block_t block = dispatch_block_create(0, ^{
        
        NSLog(@"run block1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"run end1");
        
    });
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        
        NSLog(@"run block2");
        NSLog(@"run end2");
        
    });
    
    dispatch_async(cocurrentQueue, block);
    //一般串行可取消  并行的话会提前进入任务  就无法取消当前block
    dispatch_async(cocurrentQueue, block2);
    dispatch_block_cancel(block);
    dispatch_block_cancel(block2);
    NSLog(@"end");
    
}

- (void)gcdblockNotify {
    
    dispatch_queue_t cocurrentQueue = dispatch_queue_create(queueIdendifer, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"start");
    dispatch_block_t block = dispatch_block_create(0, ^{
        
        NSLog(@"run block1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"run end1");
        
    });
    
    dispatch_async(cocurrentQueue, block);
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        
        NSLog(@"run block2");
        NSLog(@"run end2");
        
    });
    
    //可以监视指定dispatch block结束，然后再加入一个block到队列中。三个参数分别为，第一个是需要监视的block，第二个参数是需要提交执行的队列，第三个是待加入到队列中的block
    dispatch_block_notify(block, cocurrentQueue, block2);
    NSLog(@"end");
    
}

- (void)gcdblockWait {
    
    dispatch_queue_t cocurrentQueue = dispatch_queue_create(queueIdendifer, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"start");
    dispatch_block_t block = dispatch_block_create(0, ^{
        
        NSLog(@"run block");
        
    });
    
    dispatch_async(cocurrentQueue, block);
    
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_DEFAULT, -1, ^{

        [self requestNetWorkWithblock:^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"run qosblock");
        }];
        
    });
    //会一直等待block结束  异步无法监控
    dispatch_async(cocurrentQueue, qosBlock);
    dispatch_block_wait(qosBlock, DISPATCH_TIME_FOREVER);
    NSLog(@"end");
    
}

- (void)gcdafter {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"gcdafter");
    });
    
}

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
   dispatch_queue_t queue = dispatch_queue_create(queueIdendifer, DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 1000; i++) {
    
        dispatch_async(queue, ^{
            //当信号量大于0时等待结束 信号量-1
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
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//等待所有任务完成
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
