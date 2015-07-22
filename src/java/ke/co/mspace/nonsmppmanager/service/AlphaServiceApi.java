/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

import java.util.List;
import ke.co.mspace.nonsmppmanager.model.Alpha;

/**
 *
 * @author Norrey Osako
 */
public interface AlphaServiceApi {

    List<Alpha> getAllAlphanumerics();

    Alpha loadAlphanumericByUsername(String selectedUsername);

    void updateAlpha(Alpha alpha);
    
    void persistAlpha(Alpha alpha);
    
    void updateAlphaByUsername(String previousUsername, String username);
    
    public void generateXSL();
    
}
