/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

import com.lowagie.text.DocumentException;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import ke.co.mspace.nonsmppmanager.model.User;

/**
 *
 * @author Norrey Osako
 */
public interface UserServiceApi {

    List<User> getAllUsers();

    void persistUser(User user);

    public Date setEndDate();
    
    public boolean authenticateUser(String username, String password);

    public void updateUser(User aThis);

    public User loadCustomerByUsername(String selectedUsername);
    
    public void generateXSL();
    
    public void generatePDF() throws IOException, DocumentException;
    
    public Map<String, Object> simpleStatistics();
    
    public void updateCredits(String username, int smsCredits);
    
}
