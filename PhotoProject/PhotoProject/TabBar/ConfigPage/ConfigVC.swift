//
//  ConfigVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 05/05/22.
//

import UIKit

class ConfigVC: UIViewController {

    func configItems(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.myColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Configurações"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configItems()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
