//
//  CreateFarmViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 4/17/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit


@available(iOS 10.0, *)
class CreateFarmViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var farmName: UITextField!
    
    @IBOutlet weak var contact: UITextField!
    
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var zipcode: UITextField!
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet )
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion:  nil)
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        submitBtn.layer.borderWidth = 3.0
        submitBtn.layer.borderColor = UIColor.white.cgColor
        submitBtn.layer.cornerRadius = 15
        
        uploadBtn.layer.borderWidth = 3.0
        uploadBtn.layer.borderColor = UIColor.white.cgColor
        uploadBtn.layer.cornerRadius = 15

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView.endEditing(true)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMyFarm"{
            
            //            let dest = segue.destination as! FarmDetailViewController
            //            let index = tableView.indexPathForSelectedRow
            //
            //            let farm = farmArray[index!.row]
            //
            //            dest.title = farm.farmName
            //            dest.address = farm.farmAddress
            //            //            dest.ownerName = farm.owner?.name
            //            //            dest.ownerContact = farm.owner?.phone
            //            dest.city = farm.farmCity
            //            dest.postal = farm.farmPostal
            //            dest.latitude = farm.farmLatitude
            //            dest.longitude = farm.farmLongitude
            
            
            let dest = segue.destination as! FarmViewController
            dest.farmName.text = farmName.text
            dest.farmAddress.text = address.text
            dest.farmContact.text = contact.text
            dest.farmCity.text = city.text
            dest.farmZip.text = zipcode.text
            dest.farmPic.image = UIImage(named: "farm4")
            
        }
    }



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



}
    
