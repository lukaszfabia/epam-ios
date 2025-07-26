To make this, I modified your provided code snippet instead of using for-loops used sleep. I created simulation of executing tasks.
To both queues I created two tasks for each queue (longer and shorter) and added longer task before shorter.

So 2 main differences are:
1. OperationQueue.main uses main thread and the instance of OperationQueue uses a reusable thread per each task.
2. In OperationQueue.main, works sequentially so short task needs to wait for finish longer task, on the other hand OperationQueue() was executing tasks concurrently - shorter task was executed faster than longer one.
