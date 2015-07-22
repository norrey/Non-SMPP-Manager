/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Norrey Osako
 */
public interface SMSOutServiceApi {

    Map<String, Object> userSMSOutReport(String user, String startDate, String endDate);
    public void generateXSL(String user, String startDate, String endDate);

    public List<String> getUsernames();
    public Map<String, Object> smsOutGroupBy(String user, String startDate, String endDate);
    public Map<String, String> smsOutGroupByUser(String startDate, String endDate);
    public String getRealSMSStatus(String smsID);
    
}
