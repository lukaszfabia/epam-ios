maxConcurrentOperationCount is used to limit the number of concurrent tasks. In this case I checked what happens when we set maxConcurrentOperationCount less then amount of operations to execute and bigger then amount of tasks. The main diff is in the first case max number of operations is 2 so 2 tasks will be executed concurrently and the next two must wait for them to finish when we have max value more than number of tasks all tasks will be started at the same time.

By using dependencies we can create situation where some tasks depends on other. So depended task will be started after all its dependencies are finished.

queuePriority helps us to create priority queue for tasks in playground I have tested two of them .high and .low. The result? Task with high prority starts as a first and A with low priority starts as a last.
But when I use default maxConcurrentOperationCount with waiting for finishing (waitUntilFinished) task A with low priority does not start as a last (starts in the middle +-).
