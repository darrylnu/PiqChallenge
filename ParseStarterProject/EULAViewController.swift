//
//  EULAViewController.swift
//  PiqChallenge
//
//  Created by Darryl Nunn on 2/29/16.
//  Copyright © 2016 DarrylNunn. All rights reserved.
//

import UIKit

class EULAViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let html = "<html><body><h3>PiqChallenge End User License Agreement</h3><p>This End User License Agreement (“Agreement”) is between you and PiqChallenge and governs use of this app made available through the Apple App Store. By installing the PiqChallenge App, you agree to be bound by this Agreement and understand that there is no tolerance for objectionable content. If you do not agree with the terms and conditions of this Agreement, you are not entitled to use the PiqChallenge App.</p><p>In order to ensure PiqChallenge provides the best experience possible for everyone, we strongly enforce a no tolerance policy for objectionable content. If you see inappropriate content, please use the “Report as offensive” feature found under each post.</p><p>1. Parties<br>This Agreement is between you and PiqChallenge only, and not Apple, Inc. (“Apple”). Notwithstanding the foregoing, you acknowledge that Apple and its subsidiaries are third party beneficiaries of this Agreement and Apple has the right to enforce this Agreement against you. PiqChallenge, not Apple, is solely responsible for the PiqChallenge App and its content.</p><p>2. Privacy<br>PiqChallenge may collect and use information about your usage of the PiqChallenge App, including certain types of information from and about your device. PiqChallenge may use this information, as long as it is in a form that does not personally identify you, to measure the use and performance of the PiqChallenge App.</p><p>3. Limited License<br>PiqChallenge grants you a limited, non-exclusive, non-transferable, revocable license to use thePiqChallenge App for your personal, non-commercial purposes. You may only use thePiqChallenge App on Apple devices that you own or control and as permitted by the App Store Terms of Service.</p><p>4. Age Restrictions<br>By using the PiqChallenge App, you represent and warrant that (a) you are 17 years of age or older and you agree to be bound by this Agreement; (b) if you are under 17 years of age, you have obtained verifiable consent from a parent or legal guardian; and (c) your use of the PiqChallenge App does not violate any applicable law or regulation. Your access to the PiqChallenge App may be terminated without warning if PiqChallenge believes, in its sole discretion, that you are under the age of 17 years and have not obtained verifiable consent from a parent or legal guardian. If you are a parent or legal guardian and you provide your consent to your child’s use of the PiqChallenge App, you agree to be bound by this Agreement in respect to your child’s use of the PiqChallenge App.</p><p>5. Objectionable Content Policy<br>Content may not be submitted to PiqChallenge, who will moderate all content and ultimately decide whether or not to post a submission to the extent such content includes, is in conjunction with, or alongside any, Objectionable Content. Objectionable Content includes, but is not limited to: (i) sexually explicit materials; (ii) obscene, defamatory, libelous, slanderous, violent and/or unlawful content or profanity; (iii) content that infringes upon the rights of any third party, including copyright, trademark, privacy, publicity or other personal or proprietary right, or that is deceptive or fraudulent; (iv) content that promotes the use or sale of illegal or regulated substances, tobacco products, ammunition and/or firearms; and (v) gambling, including without limitation, any online casino, sports books, bingo or poker.</p><p>6. Warranty<br>PiqChallenge disclaims all warranties about the PiqChallenge App to the fullest extent permitted by law. To the extent any warranty exists under law that cannot be disclaimed, PiqChallenge, not Apple, shall be solely responsible for such warranty.</p><p>7. Maintenance and Support<br>PiqChallenge does provide minimal maintenance or support for it but not to the extent that any maintenance or support is required by applicable law, PiqChallenge, not Apple, shall be obligated to furnish any such maintenance or support.</p><p>8. Product Claims<br>PiqChallenge, not Apple, is responsible for addressing any claims by you relating to the PiqChallenge App or use of it, including, but not limited to: (i) any product liability claim; (ii) any claim that the PiqChallenge App fails to conform to any applicable legal or regulatory requirement; and (iii) any claim arising under consumer protection or similar legislation. Nothing in this Agreement shall be deemed an admission that you may have such claims.</p><p>9. Third Party Intellectual Property Claims<br>PiqChallenge shall not be obligated to indemnify or defend you with respect to any third party claim arising out or relating to the PiqChallenge App. To the extent PiqChallenge is required to provide indemnification by applicable law, PiqChallenge, not Apple, shall be solely responsible for the investigation, defense, settlement and discharge of any claim that the PiqChallenge App or your use of it infringes any third party intellectual property right.</p></body></html>"
        webView.loadHTMLString(html, baseURL: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
