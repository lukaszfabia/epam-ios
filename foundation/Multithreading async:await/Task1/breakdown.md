To make this, I modified your provided code snipped instead of using for-loops used sleep. I created simulation of executing tasks.
To both queues I created two tasks for each queue (longer and shorter) and added longer task before shorter.

So 2 main differences are:
1. OperationQueue.main uses main thread and the instance of OperationQueue uses unique thread per each task.
2. In OperationQueue.main, we have provided an order so when I started longer task, shorter had to wait until longer task finishes (works sequentially), on the other hand OperationQueue() was executing tasks concurrently - shorter task was executed faster than longer one but we can control order of execution by setting property .maxConcurrentOperationCount=1.
