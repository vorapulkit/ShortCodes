
import UIKit

enum QueueState : String {
    case ReadyToUse = "ReadyToUse"
    case OnHold = "OnHold"
    case Busy = "Busy"
}


let queueName = "CustomTestQueue"

class QueueManager: NSObject {
    
    var customQueue : OperationQueue?
    var arrOperation : NSMutableArray?
    var queueState = QueueState.ReadyToUse.rawValue;

    class var sharedInstance:QueueManager {
        struct QueueManagerInstance {
            static let instance_new = QueueManager()
        }
        return QueueManagerInstance.instance_new
    }
    class func shared() -> QueueManager {
        return sharedInstance
    }
    //MARK: 
    //MARK: Init
    func createQueue(){
        //Create Queue if not exist
        if customQueue == nil {
            customQueue = OperationQueue()
            customQueue?.name = queueName;
            customQueue?.qualityOfService = .background;
            
            arrOperation = NSMutableArray()
            prepareQueue()
        }
    }

    //MARK:
    //MARK: Operation
    func addOprToQueue( operationBlock : @escaping ()->()) {
    
        let op = BlockOperation()
        op.qualityOfService = .background
        op.addExecutionBlock {
//            print("executing" , op.name!)
//            sleep(3)
            operationBlock()
        }
        op.completionBlock = {
//            print("complete obj",op.name!)
        }
        
        arrOperation?.add(op)
        
    }
    
    func startQueue(){
        
        if queueState == QueueState.ReadyToUse.rawValue {
            queueState = QueueState.Busy.rawValue
            for cntr in 0..<(arrOperation?.count)!  {
                let oprCurrent = arrOperation?[cntr] as! BlockOperation
                if oprCurrent.isExecuting {//if already in process then skip
                    print("Queue is executing ",oprCurrent.name!)
                    continue;
                }
                customQueue?.addOperations([oprCurrent], waitUntilFinished: true)
                if cntr < (arrOperation?.count)! - 1 {
                    let operNext = arrOperation?[cntr + 1] as! Operation
                    oprCurrent.addDependency(operNext)
                }
                
            }
        }
        
        

    }
    
    //MARK:
    //MARK: Support
    func cancelQueue(){
        customQueue?.cancelAllOperations()
        prepareQueue()
    }
    
    func prepareQueue(){
        queueState = QueueState.ReadyToUse.rawValue
        arrOperation?.removeAllObjects()
    }

}
