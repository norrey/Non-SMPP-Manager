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
public class PanelMenuBean {
    
    
    private String current;
    private String currentPage="/manager/newUser.jsp";

    public String getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(String currentPage) {
        this.currentPage = currentPage;
    }

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) {
        this.current = current;
    }
    
    
    
    public String putcurrent(){
    
        System.out.println(current);
        
        return "addUser";
    }

    
}
