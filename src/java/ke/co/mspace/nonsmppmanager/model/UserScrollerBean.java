/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

/**
 *
 * @author Norrey Osako
 */
public class UserScrollerBean {
    
    private User currentUser = new User();
    private Alpha currentAlpha = new Alpha();
    
    

    /**
     * Creates a new instance of UserScrollerBean
     */
    public UserScrollerBean() {
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    public Alpha getCurrentAlpha() {
        return currentAlpha;
    }

    public void setCurrentAlpha(Alpha currentAlpha) {
        this.currentAlpha = currentAlpha;
    }
    
    

       
}
