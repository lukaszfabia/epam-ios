So in this case to clearly see the difference we can add timestaps to prints.

In the 1st case when we have a relationship between B and A, A will be executed before B. So we are sure that B will be canceled. So only A block will be executed.

In the 2nd case when we have no relationship both operations will be executed at the same time. So A block has no time to stop B. So both blocks will be executed.

Extra (for this specific case):

To achieve same behaviour like in the first case we can make these steps:

1. We should add operation A before blockB.
2. Set maxConcurrentOperationCount to 1.

These conditions gives us sequential execution and time to cancel B.
