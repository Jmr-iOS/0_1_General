/************************************************************************************************************************************/
/** @file		ViewController.swift
 *  @project    0_1 - General
 * 	@brief		general examples and uikit extensions
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	1/13/18
 * 	@last rev	2/18/18
 *
 * 	@section	Opens
 *      initialize to custom menu
 *      something fun on it
 *      buttons
 *      buttons w/img
 *      clear lib & api for future useage
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    //Vars
    var sampleTextField : UITextField!;
    
    
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

        if(verbose) { print("ViewController.init():        initialization complete"); }
            
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
        
        //Date Demo
        dateDemo();
        
        //Keyboard Demo
        keyboardDemo();
        
        //listen to 'Home' press
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)),
                                               name: NSNotification.Name.UIApplicationWillResignActive,
                                               object: nil);
    
        if(verbose) { print("ViewController.viewDidLoad(): load complete"); }
            
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        keyboardDemo()
     *  @brief      initialize the text field for keyboard demo use
     *  @details    x
     */
    /********************************************************************************************************************************/
    func keyboardDemo() {
        
        let fieldFrame = CGRect(x: 20, y: 100, width: 300, height: 40);
        
        //Init
        sampleTextField = UITextField(frame: fieldFrame);                                       /* init new field                   */
        
        //Setup
        sampleTextField.font = UIFont.systemFont(ofSize: 15);                                   /* set font                         */
        sampleTextField.borderStyle = UITextBorderStyle.roundedRect;                            /* apply rounded edges to frame     */
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no;                       /* disable auto-correct             */
        sampleTextField.keyboardType = UIKeyboardType.default;                                  /* select normal default keyboard   */
        sampleTextField.returnKeyType = UIReturnKeyType.done;                                   /* set return key type              */
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;                     /* only show 'x' when editing       */
        sampleTextField.textAlignment = .left;                                                  /* set alignment of text            */
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center;    /* apply vertical alignment         */
        sampleTextField.translatesAutoresizingMaskIntoConstraints = true;                       /* allow constraints                */
        sampleTextField.delegate = self;                                                        /* set delegate for response        */
        
        //Text
        sampleTextField.text = nil;                                                             /* left empty for placeholder       */
        sampleTextField.placeholder = "Enter text here, bitches!";                              /* text shown when empty            */

        //Keyboard
        initKeyboardMenubar();

        //Add to view
        view.addSubview(sampleTextField);
        
        print("ViewController.kbrdDemo():    textfield added to the view");
        
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
        
        if(verbose) { print("ViewController.fontDemo():    font demo complete"); }
        
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
        
        if(verbose) { print("ViewController.fcnArgsDem():  fcn args demo complete with '\(resp)'"); }
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        dateDemo()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func dateDemo() {
        
        DateUtils.printExamples();
        
        let today   = DateUtils.getToday();
        let dateStr = DateUtils.getDateString(today);
        var timeStr = DateUtils.getTimeString(today);
        if(verbose) { print("ViewController.dateDemo():    Today's date - '\(dateStr) \(timeStr)'"); }

        //Add meridian
        timeStr = DateUtils.getTimeString(today, true);
        if(verbose) { print("ViewController.dateDemo():    Today's date - '\(dateStr) \(timeStr)'"); }

        if(verbose) { print("ViewController.dateDemo():    date demo complete"); }
        
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
    
    
//**********************************************************************************************************************************//
//                                                       UITextFieldDelegate                                                        //
//**********************************************************************************************************************************//
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        
        sampleTextField.resignFirstResponder();                             /* here is the action which dismisses keyboard          */
        
        print("ViewController.textFieldShouldReturn():                  return key pressed and exiting");
        
        return true;                                                        /* normal behavior                                      */
    }

    
//**********************************************************************************************************************************//
//                                                        Keyboard Lib                                                              //
//**********************************************************************************************************************************//

    var keyboardToolbar : UIToolbar!;
    
    /********************************************************************************************************************************/
    /** @fcn        initKeyboardMenubar()
     *  @brief      initialize the keyboard for demo use
     *  @details    x
     */
    /********************************************************************************************************************************/
    func initKeyboardMenubar() {
        
        //Constants
        let images : [String] = ["attention.png", "about.png",           "albums.png", "audio.png",
                                 "bell.png",      "bookmark_ribbon.png", "cancel.png", "car.png"];
        
        //Vars
        var barButtons : [UIBarButtonItem];                                 /* used by all                                          */
        var button : UIButton;
        var img    : UIImage;
        
        //Init (9 btns)
        keyboardToolbar = UIToolbar();
        barButtons      = [UIBarButtonItem]();
        
        //Config
        keyboardToolbar.barTintColor = UIColor.lightGray;                   /* set bkgnd color                                      */
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        barButtons.append(flexBarButton);                                   /* size-to-fit                                          */

        var someCtr = 0;
        
        for image in images {
            
            //Gen Button
            img = UIImage(named: image)!;
            button = UIButton(type: .custom);
            button.tag = someCtr;
            button.setImage(img, for: .normal);
            button.addTarget(self, action:  #selector(self.keyboardResponse), for: .touchUpInside);
            barButtons.append(UIBarButtonItem(customView: button));

            //Apply Spacing
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
            barButtons.append(flexBarButton);                               /* size-to-fit                                          */
            
            //Update Tag
            someCtr = (someCtr+1);
        }
        
        //Assemble
        keyboardToolbar.items = barButtons;
        
        //Attach
        sampleTextField.inputAccessoryView = keyboardToolbar;
        
        //Cleanup
        keyboardToolbar.sizeToFit();
        
        print("ViewController.initKbrd():    keyboard menu was initialized");
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        setDoneOnKeyboard()
     *  @brief      add 'Done' option to menu bar of keyboard
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setDoneOnKeyboard() {

        let keyboardToolbar = UIToolbar();
        
        keyboardToolbar.sizeToFit();

        let button = UIButton(type: .custom);
        button.setImage(UIImage (named: "attention.png"), for: .normal);
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0);
        //button.addTarget(target, action: nil, for: .touchUpInside);
        let barButtonItem = UIBarButtonItem(customView: button);

        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard));
        
        keyboardToolbar.items = [flexBarButton, barButtonItem, doneBarButton];

        self.sampleTextField.inputAccessoryView = keyboardToolbar;

        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        keyboardResponse(sender: UIButton)
     *  @brief      respond to key selection
     *  @details    used for keyboard demo response
     */
    /********************************************************************************************************************************/
    @objc func keyboardResponse(sender: UIButton) {
        
        print("ViewController.keyboardResponse():                       keyboard key response for '\(sender.tag)'");
        
        return;
    }
    
    /********************************************************************************************************************************/
    /** @fcn        dismissKeyboard()
     *  @brief      dismiss the keyboard
     *  @details    used for keyboard demo response
     */
    /********************************************************************************************************************************/
    @objc func dismissKeyboard() {
        
        //Resign keyboard
        view.endEditing(true);
        
        print("ViewController.dismissKeyboard():                        return key pressed and exiting");

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

