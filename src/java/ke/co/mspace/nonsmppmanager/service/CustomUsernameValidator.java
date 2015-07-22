/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

/**
 *
 * @author Norrey Osako
 */
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;
import ke.co.mspace.nonsmppmanager.model.User;

/**
 * source : www.javabeat.net
 */
public class CustomUsernameValidator implements Validator {

    @Override
    public void validate(FacesContext facesContext, UIComponent arg1, Object value) throws ValidatorException {
        String inputValue = (String) value;
        UserServiceApi service = new UserServiceImpl();
        User user = service.loadCustomerByUsername(inputValue);
        boolean isValid = (user==null);
        
            if (!isValid) {
                FacesMessage facesMessage = new FacesMessage("Username already in use", "Username already in use");
                
                facesMessage.setSeverity(FacesMessage.SEVERITY_ERROR);
			throw new ValidatorException(facesMessage);
            }
        
    }
}