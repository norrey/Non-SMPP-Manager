/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

import java.util.List;
import ke.co.mspace.nonsmppmanager.service.AlphaServiceApi;
import ke.co.mspace.nonsmppmanager.service.AlphaServiceImpl;

/**
 *
 * @author Norrey Osako
 */
public class Alpha {
    
    private Long id;
    private String name;
    private String username;
    private Alpha alpha;
    private Long userid;
    private List<Alpha> listAlphas;
    private String message;
    
    /**
     * Creates a new instance of Alpha
     */
    public Alpha() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public Alpha getAlpha() {
        return loadAlphaByUsername(username);
    }

    public void setAlpha(Alpha alpha) {
        this.alpha = alpha;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public List<Alpha> getListAlphas() {
       
        return listAlphas();
    }

    public void setListAlphas(List<Alpha> listAlphas) {
        this.listAlphas = listAlphas;
    }
    
    public List<Alpha> listAlphas() {

        AlphaServiceApi alphaService = new AlphaServiceImpl();
        return alphaService.getAllAlphanumerics();
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    
    

    
    
    public void persistAlpha(){
    
        AlphaServiceImpl service = new AlphaServiceImpl();
       
        service.persistAlpha(this);
    }
    
    public Alpha loadAlphaByUsername(String username){
    
        AlphaServiceImpl service = new AlphaServiceImpl();
        return service.loadAlphanumericByUsername(username);
    }
     public void saveOrUpdateAlpha() {

       
        AlphaServiceImpl service = new AlphaServiceImpl();
        this.setId(service.loadAlphanumericByUsername(username).getId());
        this.setName(name);
        this.setUsername(username);

        service.persistAlpha(this);
        setMessage(" Alphanumeric updated successfully.");

    }
     
     public void deleteAlphanumeric() {

       
        AlphaServiceImpl service = new AlphaServiceImpl();
        this.setId(service.loadAlphanumericByUsername(username).getId());  
        this.setUsername(username);
        service.deleteAlphanumeric(this);
        setMessage(" Alphanumeric deleted successfully.");

    }
     public void generateXSL(){
     AlphaServiceApi service = new AlphaServiceImpl();
     service.generateXSL();
     
     }
    
    

    
}
