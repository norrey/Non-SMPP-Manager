/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

import javax.faces.context.FacesContext;
import ke.co.mspace.nonsmppmanager.service.UserServiceApi;
import ke.co.mspace.nonsmppmanager.service.UserServiceImpl;

/**
 *
 * @author Norrey Osako
 */
public class AuthenticationBean {

    public static final String AUTH_KEY = "non.smpp.manager";

    private String name;
    private String username;
    private String password;
    private String message;
    private String error;
    private String status;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
    
    
    
    
    

    public boolean isLoggedIn() {
        
        return FacesContext.getCurrentInstance().getExternalContext()
                .getSessionMap().get(AUTH_KEY) != null;
        
    }

    public String login() {
        UserServiceApi userService = new UserServiceImpl();
        if (userService.authenticateUser(username, password)) {
            FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(
                    AUTH_KEY, username);
            FacesContext.getCurrentInstance().getApplication().getNavigationHandler().handleNavigation(FacesContext.getCurrentInstance(), null, "manager/secret.jsf");

            return "manager";
        }
        this.status="failed";
        setError("Invalid Credentials!");
        
        return "invalidCredentials";
    }

    public String logout() {
        FacesContext.getCurrentInstance().getExternalContext().getSessionMap()
                .remove(AUTH_KEY);
        setUsername("");
        setPassword("");
        setMessage("Logout successfull");
        return "logout";
    }
}
