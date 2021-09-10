//
//  ViewController.swift
//  SayiTahminOyunu
//
//  Created by Oğulcan DEMİRTAŞ on 10.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtTahminEdilecekSayi: UITextField!
    @IBOutlet weak var imgKaydet: UIImageView!
    @IBOutlet weak var btnKaydet: UIButton! 
    @IBOutlet weak var txtTahminSayisi: UITextField!
    @IBOutlet weak var lblSonuc: UILabel!
    @IBOutlet weak var imgTahminDurum: UIImageView!
    @IBOutlet weak var btnDene: UIButton!
    @IBOutlet weak var imgYildiz1: UIImageView!
    @IBOutlet weak var imgYildiz2: UIImageView!
    @IBOutlet weak var imgYildiz3: UIImageView!
    @IBOutlet weak var imgYildiz4: UIImageView!
    @IBOutlet weak var imgYildiz5: UIImageView!
    
    //yıldızları bir dizide tutar
    var yildizlar : [UIImageView] = [UIImageView]()
    //max yapılacak deneme sayısı
    let maxDenemeSayisi : Int = 5
    //kullanıcı kaç deneme yaptı
    var denemeSayisi : Int = 0
    //tahmin edilmesi gereken sayı
    var hedefSayi : Int = -1
    //oyun başarılı bir şekilde sona ererse true olacak
    var oyunBasarili : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //program açıldığında yıldızları bir dizi haline getiriyoruz ve sayi ve tahmin kısmında çıkacak olan görselleri görünmez yapıyoruz, çünkü duruma göre çıkması gerekiyor
        yildizlar = [imgYildiz1, imgYildiz2, imgYildiz3, imgYildiz4, imgYildiz5]
        imgKaydet.isHidden = true
        imgTahminDurum.isHidden = true
        btnDene.isEnabled = false
        txtTahminEdilecekSayi.isSecureTextEntry = true // girilen sayi parola giriyormuş gibi gizlenecek
        
    }

    @IBAction func btnKaydetClicked(_ sender: UIButton) {
        
        imgKaydet.isHidden = false
        
        if let t = Int(txtTahminEdilecekSayi.text!) {
            
            hedefSayi = t
            btnDene.isEnabled = true
            txtTahminEdilecekSayi.isEnabled = false
            btnKaydet.isEnabled = false
            imgKaydet.image = UIImage(named: "onay")
        }else{
            imgKaydet.image = UIImage(named: "hata")
        }
        
    }
    @IBAction func btnDeneClicked(_ sender: UIButton) {
        //kullanıcı oyunu bitirdiyse geri dön
        if oyunBasarili == true || denemeSayisi > maxDenemeSayisi  {
        return
    }
        if let girilenSayi = Int(txtTahminSayisi.text!){
            //eğer girdiği sayı düzgünse
            denemeSayisi += 1
            yildizlar[denemeSayisi-1].image = UIImage(named: "beyazYildiz")
            
            imgTahminDurum.isHidden = false
                
            
            if girilenSayi > hedefSayi {
                imgTahminDurum.image = UIImage(named: "asagi")
                txtTahminSayisi.backgroundColor = UIColor.red
            } else if girilenSayi < hedefSayi{
                imgTahminDurum.image = UIImage(named: "yukari")
                txtTahminSayisi.backgroundColor = UIColor.red
            }
            else{
            //iki sayi birbirine eşitse
                imgTahminDurum.image = UIImage(named: "tamam")
                btnKaydet.isEnabled = true
                lblSonuc.text = "Doğru Tahmin"
                txtTahminSayisi.backgroundColor = UIColor.green
                txtTahminEdilecekSayi.isSecureTextEntry = false
                oyunBasarili = true
                
                var alertController = UIAlertController(title: "BAŞARILI", message: "TEBRİKLER BİLDİNİZ", preferredStyle: UIAlertController.Style.alert)
                var okButton = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okButton)
                present(alertController, animated: true, completion: nil)
                
                return
                
            }
            
            }
        else{
            imgTahminDurum.isHidden = false
            imgTahminDurum.image = UIImage(named: "hata")
        }
        
        if denemeSayisi == maxDenemeSayisi {
            imgTahminDurum.image = UIImage(named: "hata")
            btnDene.isEnabled = false
            lblSonuc.text = "Başarısız"
            txtTahminEdilecekSayi.isSecureTextEntry = false
            var alertController = UIAlertController(title: "BAŞARISIZ", message: "MALESEF BİLEMEDİNİZ", preferredStyle: UIAlertController.Style.alert)
            var okButton = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okButton)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        
        
    }
}

