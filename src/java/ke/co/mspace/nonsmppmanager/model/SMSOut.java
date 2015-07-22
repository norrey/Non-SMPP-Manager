/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.model;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import ke.co.mspace.nonsmppmanager.service.SMSOutServiceApi;
import ke.co.mspace.nonsmppmanager.service.SMSOutServiceImpl;

/**
 *
 * @author Norrey Osako
 */
public class SMSOut implements Serializable {

    private Long id;
    private Long rid;
    private String seqNo;
    private String serviceType;
    private String sourceAddr;
    private String destinationAddr;
    private String messagePayload;
    private char userMessageReference;
    private String timeSubmitted;
    private String timeProcessed;
    private char status;
    private String errorinfo;
    private String messageId;
    private String sentby;
    private int esmClass;
    
    private String rule;
    private String user;
    private String submittedby;

    private Date reportStartDate = new Date();
    private Date reportEndDate = new Date();
    private int smsCount;
    private String displayTimeSubmitted;
    private String displayTimeProcessed;
    private List<String> usernames;
    private int totaSMS = 0;
    private String users;
    private String realStatus;

    public void SMSOut() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, -1);
        this.reportStartDate = cal.getTime();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRid() {
        return rid;
    }

    public void setRid(Long rid) {
        this.rid = rid;
    }

    public String getSeqNo() {
        return seqNo;
    }

    public void setSeqNo(String seqNo) {
        this.seqNo = seqNo;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getSourceAddr() {
        return sourceAddr;
    }

    public void setSourceAddr(String sourceAddr) {
        this.sourceAddr = sourceAddr;
    }

    public String getDestinationAddr() {
        return destinationAddr;
    }

    public void setDestinationAddr(String destinationAddr) {
        this.destinationAddr = destinationAddr;
    }

    public String getMessagePayload() {
        return messagePayload;
    }

    public void setMessagePayload(String messagePayload) {
        this.messagePayload = messagePayload;
    }

    public char getUserMessageReference() {
        return userMessageReference;
    }

    public void setUserMessageReference(char userMessageReference) {
        this.userMessageReference = userMessageReference;
    }

    public String getTimeSubmitted() {
        return timeSubmitted;
    }

    public void setTimeSubmitted(String timeSubmitted) {
        this.timeSubmitted = timeSubmitted;
    }

    public String getTimeProcessed() {
        return timeProcessed;
    }

    public void setTimeProcessed(String timeProcessed) {
        this.timeProcessed = timeProcessed;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        
        this.status = status;
    }

    public String getErrorinfo() {
        return errorinfo;
    }

    public void setErrorinfo(String errorinfo) {
        this.errorinfo = errorinfo;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getSentby() {
        return sentby;
    }

    public void setSentby(String sentby) {
        this.sentby = sentby;
    }

    public int getEsmClass() {
        return esmClass;
    }

    public void setEsmClass(int esmClass) {
        this.esmClass = esmClass;
    }

    

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getSubmittedby() {
        return submittedby;
    }

    public void setSubmittedby(String submittedby) {
        this.submittedby = submittedby;
    }

    public Date getReportStartDate() {
        return reportStartDate;
    }

    public void setReportStartDate(Date reportStartDate) {
        this.reportStartDate = reportStartDate;
    }

    public Date getReportEndDate() {
        return reportEndDate;
    }

    public void setReportEndDate(Date reportEndDate) {
        this.reportEndDate = reportEndDate;
    }

    public int getSmsCount() {

        return getSmsCount(messagePayload);

    }

    public void setSmsCount(int smsCount) {
        this.smsCount = smsCount;
    }

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }

    public String getRealStatus() {
        SMSOutServiceApi service = new SMSOutServiceImpl();
        String realSMSStatus = service.getRealSMSStatus(String.valueOf(status));
        return realSMSStatus;
    }

    public void setRealStatus(String realStatus) {
        this.realStatus = realStatus;
    }
    
   
    

    public int getTotaSMS() {
        SMSOutServiceApi service = new SMSOutServiceImpl();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String startDate = simpleDateFormat.format(reportStartDate);
        String endDate = simpleDateFormat.format(reportEndDate);

        int noSMS = (Integer) service.userSMSOutReport(user, startDate, endDate).get("noSMS");
        return noSMS;
    }

    public void setTotaSMS(int totaSMS) {
        this.totaSMS = totaSMS;
    }

    public String getDisplayTimeSubmitted() {

        SimpleDateFormat displayFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Date d = null;
        try {
            d = displayFormat.parse(timeSubmitted);
        } catch (ParseException ex) {
            Logger.getLogger(SMSOut.class.getName()).log(Level.SEVERE, null, ex);
        }
        displayFormat.applyPattern("yyyy-MM-dd HH:mm:ss");
        displayTimeSubmitted = displayFormat.format(d);

        return displayTimeSubmitted;
    }

    public void setDisplayTimeSubmitted(String displayTimeSubmitted) {
        this.displayTimeSubmitted = displayTimeSubmitted;
    }

    public String getDisplayTimeProcessed() {
        SimpleDateFormat displayFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Date d = null;
        try {
            d = displayFormat.parse(timeProcessed);
        } catch (ParseException ex) {
            Logger.getLogger(SMSOut.class.getName()).log(Level.SEVERE, null, ex);
        }
        displayFormat.applyPattern("yyyy-MM-dd HH:mm:ss");
        displayTimeProcessed = displayFormat.format(d);

        return displayTimeProcessed;
    }

    public void setDisplayTimeProcessed(String displayTimeProcessed) {
        this.displayTimeProcessed = displayTimeProcessed;
    }

    public List<SMSOut> smsOutReport() {

        SMSOutServiceApi service = new SMSOutServiceImpl();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String startDate = simpleDateFormat.format(reportStartDate);
        String endDate = simpleDateFormat.format(reportEndDate);

        List<SMSOut> report = (List) service.userSMSOutReport(user, startDate, endDate).get("result");

        return report;
    }

    public String smsOutReport2() {

        SMSOutServiceApi service = new SMSOutServiceImpl();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String startDate = simpleDateFormat.format(reportStartDate);
        String endDate = simpleDateFormat.format(reportEndDate);

        List<Object[]> report = (List) service.smsOutGroupBy(user, startDate, endDate).get("result");

//        List<Object[]> report = (List) service.smsOutGroupBy("MSPACE", "20130828083200", "20141128083200").get("result");
        StringBuilder stringBuilder = new StringBuilder();
        
        for (Object[] pieData : report) {
            stringBuilder.append("[");
            stringBuilder.append('"');
            stringBuilder.append(pieData[0]);
            stringBuilder.append(" ");
            stringBuilder.append(pieData[1]);
            stringBuilder.append('"');
            stringBuilder.append(",");
            stringBuilder.append(pieData[2]);
            stringBuilder.append("]");
            stringBuilder.append(",");
        }
        
        System.out.println("Maduka : "+ stringBuilder.toString());
        if(stringBuilder.toString().equals("")){
        
            return null;
        }
         
        String   pieChartData = stringBuilder.toString().substring(0,
                    stringBuilder.toString().length() - 1);
        

        return pieChartData;
    }
    
    public String smsOutReport3() {

        SMSOutServiceApi service = new SMSOutServiceImpl();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String startDate = simpleDateFormat.format(reportStartDate);
        String endDate = simpleDateFormat.format(reportEndDate);

       // List<Object[]> report = (List) service.smsOutGroupByUser(startDate, endDate).get("result");

//        List<Object[]> report = (List) service.smsOutGroupBy("MSPACE", "20130828083200", "20141128083200").get("result");
        StringBuilder stringBuilder = new StringBuilder();
        
        Map<String, String> output = service.smsOutGroupByUser(startDate, endDate);
        
        System.out.println("Maduka : "+ stringBuilder.toString());
        if(output.equals("")){
        
            return null;
        }
         
        
        setUsers(output.get("users"));
        
        System.out.println("SMSOUT USERS: "+ users);

        return output.get("data");
    }

    public void generateXLSX() {

        SMSOutServiceApi service = new SMSOutServiceImpl();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String startDate = simpleDateFormat.format(reportStartDate);
        String endDate = simpleDateFormat.format(reportEndDate);
        service.generateXSL(user, startDate, endDate);

    }

    public List<String> getUsernames() {
        SMSOutServiceApi service = new SMSOutServiceImpl();
        return service.getUsernames();
    }

    private int getSmsCount(String msg) {
        int ret = 0;

        if (msg == null || msg.length() <= 160) {
            return 1;
        }
        ret = msg.length() / 134;
        if (msg.length() % 134 > 0) {
            ret++;
        }
        return ret;
    }

}
