/************************************************************************************************************************************/
/** @file		ViewController.swift
 *  @project    0_1 - General
 * 	@brief		general examples and uikit extensions
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	1/13/18
 * 	@last rev	1/13/18
 *
 * 	@section	Opens
 * 	    none current
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController {

    
    /********************************************************************************************************************************/
    /** @fcn        init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        //@todo     init state
        
        //Super
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        //@todo     init code
        DataBackup.loadData();													/* use here if backup needed						*/
        DataBackup.saveData();

        print("ViewController.init():        initialization complete");
            
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        viewDidLoad()
     *  @brief      Called after the controller's view is loaded into memory
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;

        //Font
        fontDemo();

        //Function Arguments
        funcArgsDemo();
        
        //listen to 'Home' press
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)),
                                               name: NSNotification.Name.UIApplicationWillResignActive,
                                               object: nil);
    
        print("ViewController.viewDidLoad(): load complete");
            
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        fontDemo()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func fontDemo() {

        //Init
        let origLabel = UILabel();
        origLabel.font = UIFont(name: "MarkerFelt-Thin", size: 35);
        origLabel.textAlignment = .center;
        origLabel.numberOfLines = 5;
        origLabel.frame = CGRect(x: 15, y: 150, width: 300, height: 400);
        origLabel.translatesAutoresizingMaskIntoConstraints = true;
        origLabel.text = "Original Font Size";

        let diffLabel = UILabel();
        diffLabel.font = UIFont(name: "MarkerFelt-Thin", size: 35);
        diffLabel.textAlignment = .center;
        diffLabel.numberOfLines = 5;
        diffLabel.frame = CGRect(x: 15, y: 200, width: 300, height: 400);
        diffLabel.translatesAutoresizingMaskIntoConstraints = true;
        diffLabel.text = "Smaller Font Size";
        
        //Soln
        diffLabel.font = diffLabel.font.updateSize(-10);
        
        //Add to view
        view.addSubview(origLabel);
        view.addSubview(diffLabel);
        
        print("ViewController.viewDidLoad(): load complete");
        
        return;
        
    }

    
    /********************************************************************************************************************************/
    /** @fcn        funcArgsDemo()
     *  @brief      x
     *  @details    see EOF for FcnArgs class
     */
    /********************************************************************************************************************************/
    func funcArgsDemo() {
        
        //Pass function as arg
        let fPtr = FcnArgs.funcToPointTo;                           /* of type '((Int)->String)'                                    */
        
        let resp = fPtr(4);
        
        print("ViewController.init():        \(resp)");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        applicationWillResignActive(_ notification: Notification)
     *  @brief      Tells the delegate that the app is about to become inactive
     *  @details    This method is called to let your app know that it is about to move from the active to inactive state
     *  @class      UIApplicationDelegate
     */
    /********************************************************************************************************************************/
    func applicationWillResignActive(_ notification: Notification) {
        print("I'm out of focus, home was pressed!");
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        didReceiveMemoryWarning()
     *  @brief      Sent to the view controller when the app receives a memory warning
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        init?(coder aDecoder: NSCoder)
     *  @brief      backup restore initialization
     *  @details    x
     *
     *  @param      [in] (NSCoder) aDecoder - memory query device (backup access)
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}


//Function Arguments Class
class FcnArgs {
    class func funcToPointTo(_ i : Int) -> String {
        print("FcnArgs.funcToPointTo():      i was passed \(i)");
        return "I was returned";
    }
}

