/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

import java.util.Date;
import ke.co.mspace.nonsmppmanager.service.ManageCreditApi;
import ke.co.mspace.nonsmppmanager.service.ManageCreditImpl;

/**
 *
 * @author mspace
 */
public class SMSCredits {
    private Long id;
    private String username;
    private char actionType;
    private Date actionTime;
    private int numCredits;

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

    public char isActionType() {
        return actionType;
    }

    public void setActionType(char actionType) {
        this.actionType = actionType;
    }

    public Date getActionTime() {
        return actionTime;
    }

    public void setActionTime(Date actionTime) {
        this.actionTime = actionTime;
    }

    public int getNumCredits() {
        return numCredits;
    }

    public void setNumCredits(int numCredits) {
        this.numCredits = numCredits;
    }
    
    public void persistUpdate(){
        
        ManageCreditApi manager= new ManageCreditImpl();
        manager.persistUpdate(this);
        
    }
    
}
