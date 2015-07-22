/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

import com.lowagie.text.DocumentException;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.constraints.Pattern;
import ke.co.mspace.nonsmppmanager.service.AlphaServiceApi;
import ke.co.mspace.nonsmppmanager.service.AlphaServiceImpl;
import ke.co.mspace.nonsmppmanager.service.ManageCreditApi;
import ke.co.mspace.nonsmppmanager.service.ManageCreditImpl;
import ke.co.mspace.nonsmppmanager.service.UserServiceApi;
import ke.co.mspace.nonsmppmanager.service.UserServiceImpl;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author Norrey Osako
 */
public class User {

    private Long id;

    @NotEmpty(message = "Username required")
    @Pattern(regexp = "^[a-z0-9_-]{3,16}$", message = "Invalid Username")
    private String username;

    @NotEmpty(message = "Password required")
    @Length(min = 6, message = "Six or more characters")
    private String password;

    
    private int smsCredits;

    @NotEmpty(message = "Organization name required")
    private String organization;

    @NotEmpty(message = "Mobile number required")
    @Pattern(regexp = "^[0-9]*$", message="Invalid Number")
    private String userMobile;

    @NotEmpty(message = "Email required")
    @Pattern(regexp = ".+@.+\\..+", message = "Invalid Email")
    private String userEmail;

    private Date startDate;
    private Date endDate;
    private boolean enableEmailAlertWhenCreditOver;
    private List<User> listUsers;
    private String selectedUsername;
    private String previousUsername;
    private String message;
    private String alphanumeric;
    private int creditsToManage;
    private char admin;
    private String creditManageType;

    public User() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSmsCredits() {
        return smsCredits;
    }

    public void setSmsCredits(int smsCredits) {
        this.smsCredits = smsCredits;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isEnableEmailAlertWhenCreditOver() {
        return enableEmailAlertWhenCreditOver;
    }

    public void setEnableEmailAlertWhenCreditOver(boolean enableEmailAlertWhenCreditOver) {
        this.enableEmailAlertWhenCreditOver = enableEmailAlertWhenCreditOver;
    }

    public List<User> getListUsers() {
        return listUsers();
    }

    public void setListUsers(List<User> listUsers) {
        this.listUsers = listUsers;
    }

    public String getSelectedUsername() {
        return selectedUsername;
    }

    public void setSelectedUsername(String selectedUsername) {
        this.selectedUsername = selectedUsername;
    }

    public String getAlphanumeric() {
        AlphaServiceImpl service = new AlphaServiceImpl();
        return service.loadAlphanumericByUsername(username).getName();
    }

    public void setAlphanumeric(String alphanumeric) {
        this.alphanumeric = alphanumeric;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getCreditsToManage() {
        return creditsToManage;
    }

    public void setCreditsToManage(int creditsToManage) {
        this.creditsToManage = creditsToManage;
    }

    public String getPreviousUsername() {
        return username;
    }

    public void setPreviousUsername(String previousUsername) {
        this.previousUsername = previousUsername;
    }
    
    

    public void manageCredit() {
        SMSCredits smsCredit = new SMSCredits();
        ManageCreditApi creditManager = new ManageCreditImpl();
        UserServiceApi userService = new UserServiceImpl();

        smsCredit.setUsername(username);
        smsCredit.setActionTime(new Date());

        switch (creditManageType) {
            case "add":
                this.smsCredits = smsCredits + creditsToManage;
                smsCredit.setActionType('1');
                smsCredit.setNumCredits(creditsToManage);
                creditManager.persistUpdate(smsCredit);
                userService.updateCredits(username, smsCredits);
                setMessage("You have successfully added "+creditsToManage + " SMS Credits to user "+ username);
                break;
            case "update":
                this.smsCredits = creditsToManage;
                smsCredit.setActionType('2');
                smsCredit.setNumCredits(creditsToManage);
                creditManager.persistUpdate(smsCredit);
                userService.updateCredits(username, smsCredits);
                setMessage("You have successfully altered and changed "+ username + "'s SMS credits to "+ creditsToManage);
                break;
        }

    }

    public String getCreditManageType() {

        return creditManageType;
    }

    public void setCreditManageType(String creditManageType) {
        this.creditManageType = creditManageType;
    }

    public char getAdmin() {
        return admin;
    }

    public void setAdmin(char admin) {
        this.admin = admin;
    }

    public void saveUser() {

        UserServiceApi service = new UserServiceImpl();
        ManageCreditApi creditManager = new ManageCreditImpl();
        this.setEndDate(service.setEndDate());
        this.setStartDate(new Date());
        this.setAdmin('2');
        service.persistUser(this);
        
        SMSCredits credits = new SMSCredits();
        credits.setActionTime(new Date());
        credits.setActionType('1');
        credits.setNumCredits(smsCredits);
        credits.setUsername(username);
        creditManager.persistUpdate(credits);
        saveAlpha();
        
        setMessage("User saved successfully.");
        clearAll();

    }

    public void updateUser() {

        UserServiceApi service = new UserServiceImpl();
        AlphaServiceApi alphaService = new AlphaServiceImpl();
        this.setEndDate(service.setEndDate());
        this.setStartDate(new Date());
        this.setAdmin('2');
        System.out.println("Previous username :" + previousUsername);
        alphaService.updateAlphaByUsername(previousUsername, username);
        service.updateUser(this);
        setMessage("User info updated succssfully.");

    }

    public List<User> listUsers() {

        UserServiceApi userService = new UserServiceImpl();
        return userService.getAllUsers();
    }

    public void fullProfile() {

        UserServiceApi userService = new UserServiceImpl();
        User aUser = userService.loadCustomerByUsername(username);
        this.id = aUser.getId();
        this.username = aUser.getUsername();
        this.userEmail = aUser.getUserEmail();
        this.userMobile = aUser.getUserMobile();
        this.password = aUser.getPassword();
        this.smsCredits = aUser.getSmsCredits();
        this.organization = aUser.getOrganization();

    }

    public void saveOrUpdateAlpha() {

        Alpha alpha = new Alpha();
        AlphaServiceImpl service = new AlphaServiceImpl();
        alpha.setId(service.loadAlphanumericByUsername(username).getId());
        alpha.setName(alphanumeric);
        alpha.setUsername(username);

        service.persistAlpha(alpha);
        setMessage("User alpha updated successfully.");

    }
    
    public void saveAlpha() {

        Alpha alpha = new Alpha();
        AlphaServiceImpl service = new AlphaServiceImpl();
        alpha.setName(alphanumeric);
        alpha.setUsername(username);

        service.persistAlpha(alpha);
        

    }

    public void generateXSL() {
        UserServiceApi service = new UserServiceImpl();
        service.generateXSL();
    }

    public void generatePDF() throws IOException {
        UserServiceApi service = new UserServiceImpl();
        try {
            service.generatePDF();
        } catch (DocumentException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Map<String, Object> simpleStatistics() {

        UserServiceApi service = new UserServiceImpl();
        Map<String, Object> stats = service.simpleStatistics();
        return stats;
    }

    public void clearAll() {

        this.username = "";
        this.userMobile = "";
        this.userEmail = "";
        this.smsCredits = 0;
        this.password = "";
        this.organization = "";

    }

}
