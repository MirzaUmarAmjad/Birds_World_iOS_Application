//
//  postUploadTableViewController.swift
//  birdsWorld
//
//  Created by Umar Amjad on 19/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import UIKit
import TextFieldEffects
import BSImagePicker
import Photos
import iOSDropDown

class postUploadTableViewController: UITableViewController {
    
    let imagePicker = ImagePickerController()
    var selectedImage = [Data]()
   
    @IBOutlet weak var postTitle: HoshiTextField!
    @IBOutlet weak var postRingNumber: HoshiTextField!
    @IBOutlet weak var postMutation: HoshiTextField!
    @IBOutlet weak var postSplit: HoshiTextField!
    @IBOutlet weak var postPrice: HoshiTextField!
    @IBOutlet weak var postParentsMaleMutation: HoshiTextField!
    @IBOutlet weak var postParentFemaleMutation: HoshiTextField!
    @IBOutlet weak var postAgeInMonths: HoshiTextField!
    @IBOutlet weak var postAddress: HoshiTextField!
    @IBOutlet weak var postPhone: HoshiTextField!
    @IBOutlet weak var postImageUploadLabel: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var postCategory: DropDown!
    @IBOutlet weak var postGender: DropDown!
    @IBOutlet weak var postCity: DropDown!
    
    

    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        postGender.optionArray = ["Not Know", "Male", "Female"]
        postCategory.optionArray = ["Lovebird", "Budgerigar", "Finch", "Java", "Exotic Bird", "Other"]
        postCity.optionArray = ["Islamabad" ,"AhmedNagerChatha" ,"AhmadpurEast" ,"AliKhanAbad" ,"Alipur" ,"Arifwala" ,"Attock" ,"Bhera" ,"Bhalwal" ,"Bahawalnagar" ,"Bahawalpur" ,"Bhakkar" ,"Burewala" ,"Chillianwala" ,"Chakwal" ,"Chichawatni" ,"Chiniot" ,"Chishtian" ,"Daska" ,"DaryaKhan" ,"DeraGhaziKhan" ,"Dhaular" ,"Dina" ,"Dinga" ,"Dipalpur" ,"Faisalabad" ,"FatehJhang" ,"GhakharMandi" ,"Gojra" ,"Gujranwala" ,"Gujrat" ,"GujarKhan" ,"Hafizabad" ,"Haroonabad" ,"Hasilpur" ,"Haveli" ,"Lakha" ,"Jalalpur" ,"Jattan" ,"Jampur" ,"Jaranwala" ,"Jhang" ,"Jhelum" ,"Kalabagh" ,"KarorLalEsan" ,"Kasur" ,"Kamalia" ,"Kamoke" ,"Khanewal" ,"Khanpur" ,"Kharian" ,"Khushab" ,"KotAdu" ,"Jauharabad" ,"Lahore" ,"Lalamusa" ,"Layyah" ,"LiaquatPur" ,"Lodhran" ,"Malakwal" ,"Mamoori" ,"Mailsi" ,"MandiBahauddin" ,"mianChannu" ,"Mianwali" ,"Multan" ,"Murree" ,"Muridke" ,"MianwaliBangla" ,"Muzaffargarh" ,"Narowal" ,"Okara" ,"RenalaKhurd" ,"Pakpattan" ,"Pattoki" ,"PirMahal" ,"Qaimpur" ,"QilaDidarSingh" ,"Rabwah" ,"Raiwind" ,"Rajanpur" ,"RahimYarKhan" ,"Rawalpindi" ,"Sadiqabad" ,"Safdarabad" ,"Sahiwal" ,"SanglaHill" ,"SaraiAlamgir" ,"Sargodha" ,"Shakargarh" ,"Sheikhupura" ,"Sialkot" ,"Sohawa" ,"Soianwala" ,"Siranwali" ,"Talagang" ,"Taxila" ,"TobaTekSingh" ,"Vehari" ,"WahCantonment" ,"Wazirabad" ,"Badin" ,"Bhirkan" ,"RajoKhanani" ,"Chak" ,"Dadu" ,"Digri" ,"Diplo" ,"Dokri" ,"Ghotki" ,"Haala" ,"Hyderabad" ,"Islamkot" ,"Jacobabad" ,"Jamshoro" ,"Jungshahi" ,"Kandhkot" ,"Kandiaro" ,"Karachi" ,"Kashmore" ,"KetiBandar" ,"Khairpur" ,"Kotri" ,"Larkana" ,"Matiari" ,"Mehar" ,"MirpurKhas" ,"Mithani" ,"Mithi" ,"Mehrabpur" ,"Moro" ,"Nagarparkar" ,"Naudero" ,"NaushahroFeroze" ,"Naushara" ,"Nawabshah" ,"Nazimabad" ,"Qambar" ,"Qasimabad" ,"Ranipur" ,"Ratodero" ,"Rohri" ,"Sakrand" ,"Sanghar" ,"Shahbandar" ,"Shahdadkot" ,"Shahdadpur" ,"ShahpurChakar" ,"Shikarpaur" ,"Sukkur" ,"Tangwani" ,"TandoAdamKhan" ,"TandoAllahyar" ,"TandoMuhammadKhan" ,"Thatta" ,"Umerkot" ,"Warah" ,"Abbottabad" ,"Adezai" ,"Alpuri" ,"AkoraKhattak" ,"Ayubia" ,"BandaDaudShah" ,"Bannu" ,"Batkhela" ,"Battagram" ,"Birote" ,"Chakdara" ,"Charsadda" ,"Chitral" ,"Daggar" ,"Dargai" ,"DaryaKhan" ,"deraIsmailKhan" ,"Doaba" ,"Dir" ,"Drosh" ,"Hangu" ,"Haripur" ,"Karak" ,"Kohat" ,"Kulachi" ,"LakkiMarwat" ,"Latamber" ,"Madyan" ,"Mansehra" ,"Mardan" ,"Mastuj" ,"Mingora" ,"Nowshera" ,"Paharpur" ,"Pabbi" ,"Peshawar" ,"SaiduSharif" ,"Shorkot" ,"ShewaAdda" ,"Swabi" ,"Swat" ,"Tangi" ,"Tank" ,"Thall" ,"Timergara" ,"Tordher" ,"Awaran" ,"Barkhan" ,"Chagai" ,"DeraBugti" ,"Gwadar" ,"Harnai" ,"Jafarabad" ,"JhalMagsi" ,"Kacchi" ,"Kalat" ,"Kech" ,"Kharan" ,"Khuzdar" ,"KillaAbdullah" ,"KillaSaifullah" ,"Kohlu" ,"Lasbela" ,"Lehri" ,"Loralai" ,"Mastung" ,"Musakhel" ,"Nasirabad" ,"Nushki" ,"Panjgur" ,"Pishinvalley" ,"Quetta" ,"Sherani" ,"Sibi" ,"Sohbatpur" ,"Washuk" ,"Zhob" ,"Ziarat"]
       
        
        postImageUploadLabel.text = "selected images:0"
        
    }
    
    
    @IBAction func postSubmit(_ sender: Any) {
        
        
        if postTitle.text!.length == 0 {
            self.view.makeToast(message: "Enter Title" )
            return
        }
        
        if postRingNumber.text!.length == 0 {
            self.view.makeToast(message: "Enter Ring Number" )
            return
        }
        
        if postMutation.text!.length == 0 {
            self.view.makeToast(message: "Enter Mutation" )
            return
        }
        
        if postPrice.text!.length == 0 {
            self.view.makeToast(message: "Enter Price" )
            return
        }
        
        if postAddress.text!.length == 0 {
            self.view.makeToast(message: "Enter Address" )
            return
        }
        
        if postPhone.text!.length == 0 {
            self.view.makeToast(message: "Enter Phone" )
            return
        }
       
        if selectedImage.count == 0 {
            self.view.makeToast(message: "select Images" )
            return
        }
        
        if postDescription.text!.length == 0 {
            self.view.makeToast(message: "Enter Description" )
            return
        }
        
        if postCategory.text!.count == 0 {
            self.view.makeToast(message: "Enter Category" )
            return
        }
        
        if postGender.text!.length == 0 {
            self.view.makeToast(message: "Enter Gender" )
            return
        }
        
        if postCity.text!.length == 0 {
            self.view.makeToast(message: "Enter City" )
            return
        }
        
        
        //create object
        let defaults = UserDefaults.standard
        
        startActivity()
        API.postAd(ringNumber: postRingNumber.text!, mutation: postMutation.text!, split: postSplit.text!, user_id: defaults.string(forKey: Const.UserID)!, parentMaleMutation: postParentsMaleMutation.text!, parentFemaleMutation: postParentFemaleMutation.text!, gender: postGender.text!, category: postCategory.text!, age: postAgeInMonths.text!, city: postCity.text!, phone: postPhone.text!, description: postDescription.text!, title: postTitle.text!, price: postPrice.text!, addess: postAddress.text!, photos: self.selectedImage){ json, error in
            
            
            if json == nil{
                self.stopActivity()
                self.view.makeToast(message: "Please try again." )
                return
            }
            else{
                
                self.stopActivity()
            
            
                // create the alert
                let alert = UIAlertController(title: "Post", message: "Ad post is submitted", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(handler) in
                    self.gotoDashboard()
                } ))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func postUploadImageSubmit(_ sender: Any) {
        print("image picker")
        
        
        presentImagePicker(imagePicker, select: { (asset) in
                    // User selected an asset. Do something with it. Perhaps begin processing/upload?
                }, deselect: { (asset) in
                    // User deselected an asset. Cancel whatever you did when asset was selected.
                }, cancel: { (assets) in
                    // User canceled selection.
                }, finish: { (assets) in

                    let options = PHImageRequestOptions()
                    options.isSynchronous = true

                    for asset in assets{

                        // Request the maximum size. If you only need a smaller size make sure to request that instead.
                        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
                            // Do something with image
                            let imgdata = image!.jpegData(compressionQuality: 0)
                            self.selectedImage.append(imgdata!)
        //                    print()
                        }


                    }
                    
                    self.postImageUploadLabel.text = "selected images: \(assets.count)"

                })
        
    }
    
    func gotoDashboard() {
         self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func startActivity()
    {
        self.view.isUserInteractionEnabled = false
        view.makeToastActivity()
    }
    func stopActivity()
    {
        self.view.isUserInteractionEnabled = true
        view.hideToastActivity()
    }
    
   
}
