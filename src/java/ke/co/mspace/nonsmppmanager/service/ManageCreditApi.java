/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

import ke.co.mspace.nonsmppmanager.model.SMSCredits;

/**
 *
 * @author mspace
 */
public interface ManageCreditApi {
    
    public void persistUpdate(SMSCredits smsCredits);
    
}
