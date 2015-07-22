/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ke.co.mspace.nonsmppmanager.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import ke.co.mspace.nonsmppmanager.model.SMSOut;
import ke.co.mspace.nonsmppmanager.model.SMSStatus;
import ke.co.mspace.nonsmppmanager.util.HibernateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.type.Type;

/**
 *
 * @author Norrey Osako
 */
public class SMSOutServiceImpl implements SMSOutServiceApi {

    private final static DateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

    @Override
    public Map<String, Object> userSMSOutReport(String user, String startDate, String endDate) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        Criteria criteria = session.createCriteria(SMSOut.class);
        criteria.add(Restrictions.eq("user", user));
        criteria.add(Restrictions.between("timeSubmitted", startDate, endDate));

        List<SMSOut> result = criteria.list();
        int noSMS = 0;
        for (SMSOut sms : result) {
            noSMS += sms.getSmsCount();
        }

        Map<String, Object> mapResult = new HashMap<>();
        mapResult.put("result", result);
        mapResult.put("noSMS", noSMS);

        System.out.println("No of SMS from Bean: " + noSMS);
        session.getTransaction().commit();
        return mapResult;
    }

    @Override
    public void generateXSL(String user, String startDate, String endDate) {
        try {

            HSSFWorkbook wb = new HSSFWorkbook();
            Map<String, CellStyle> styles = createStyles(wb);
            HSSFSheet sheet = wb.createSheet("Users_Sheet1");

            PrintSetup printSetup = sheet.getPrintSetup();
            printSetup.setLandscape(true);
            sheet.setFitToPage(true);
            sheet.setHorizontallyCenter(true);

            //title row
            Row titleRow = sheet.createRow(0);
            titleRow.setHeightInPoints(45);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("SMS OUT REPORT");
            titleCell.setCellStyle(styles.get("title"));
            sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$H$1"));

            String[] titles = {"Mobile", "Source Address", "Message", "Time Spent", "Last Update", "User", "Status", "No. of SMS"};

            HSSFRow row = sheet.createRow(1);
            row.setHeightInPoints(40);

            Cell headerCell;
            for (int i = 0; i < titles.length; i++) {
                headerCell = row.createCell(i);
                headerCell.setCellValue(titles[i]);
                headerCell.setCellStyle(styles.get("header"));
            }

            List<SMSOut> exportSMSOutReport = (List) userSMSOutReport(user, startDate, endDate).get("result");
            int rowNum = 2;

            for (SMSOut anSMS : exportSMSOutReport) {
                row = sheet.createRow(rowNum);
                row.createCell(0).setCellValue(anSMS.getDestinationAddr());
                row.createCell(1).setCellValue(anSMS.getSourceAddr());
                row.createCell(2).setCellValue(anSMS.getMessagePayload());
                row.createCell(3).setCellValue(anSMS.getTimeSubmitted());
                row.createCell(4).setCellValue(anSMS.getTimeProcessed());

                row.createCell(5).setCellValue(anSMS.getUser());
                row.createCell(6).setCellValue(anSMS.getRealStatus());
                row.createCell(7).setCellValue(anSMS.getSmsCount());
                rowNum++;
            }

            sheet.setColumnWidth(0, 20 * 256); //30 characters wide
            sheet.setColumnWidth(1, 15 * 256);
            for (int i = 2; i < 5; i++) {
                sheet.setColumnWidth(i, 20 * 256);  //6 characters wide
            }
            sheet.setColumnWidth(5, 10 * 256);

            sheet.setColumnWidth(6, 20 * 256);
            sheet.setColumnWidth(7, 10 * 256); //10 characters wide

            FacesContext context = FacesContext.getCurrentInstance();
            HttpServletResponse res = (HttpServletResponse) context.getExternalContext().getResponse();
            res.setContentType("application/vnd.ms-excel");
            res.setHeader("Content-disposition", "attachment;filename=mydata.xlsx");

            ServletOutputStream out = res.getOutputStream();
            wb.write(out);
            out.flush();
            out.close();
            FacesContext.getCurrentInstance().responseComplete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<String> getUsernames() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();

        Criteria criteria = session.createCriteria(SMSOut.class);
        criteria.setProjection(Projections.distinct(Projections.property("user")));
        List<String> result = criteria.list();
        session.getTransaction().commit();
        return result;
    }

    private static Map<String, CellStyle> createStyles(Workbook wb) {
        Map<String, CellStyle> styles = new HashMap<>();
        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short) 18);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put("title", style);

        Font monthFont = wb.createFont();
        monthFont.setFontHeightInPoints((short) 11);
        monthFont.setColor(IndexedColors.WHITE.getIndex());
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(monthFont);
        style.setWrapText(true);
        styles.put("header", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cell", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
        styles.put("formula", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
        styles.put("formula_2", style);

        return styles;
    }

    @Override
    public Map<String, Object> smsOutGroupBy(String user, String startDate, String endDate) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        Criteria criteria = session.createCriteria(SMSOut.class);

        /*
         * This is where the report is going to come from
         * projectionList.add(Projections.sqlGroupProjection("YEAR(time_submitted) as yearSubmitted, MONTHNAME(STR_TO_DATE(MONTH(time_submitted), '%m')) as monthSubmitted, time_submitted as timeSubmitted", "timeSubmitted", new String[] { "monthSubmitted", "timeSubmitted", "yearSubmitted" }, new Type[] { StandardBasicTypes.STRING }));
         */
        ProjectionList projectionList = Projections.projectionList();
        projectionList.add(Projections.sqlGroupProjection("YEAR(time_submitted) as yearSubmitted, MONTHNAME(STR_TO_DATE(MONTH(time_submitted), '%m')) as timeSubmitted", "yearSubmitted, timeSubmitted", new String[]{"yearSubmitted", "timeSubmitted"}, new Type[]{StandardBasicTypes.LONG, StandardBasicTypes.STRING}));

        projectionList.add(Projections.rowCount());

        criteria.setProjection(projectionList); //This is added
        criteria.add(Restrictions.eq("user", user));
        criteria.addOrder(Order.asc("timeSubmitted"));
        criteria.add(Restrictions.between("timeSubmitted", startDate, endDate));

        List<Object[]> results = criteria.list();

        for (Object[] aResult : results) {
            System.out.println("the Object: " + Arrays.deepToString(aResult));
            System.out.println("Year : " + aResult[0] + " Month : " + aResult[1] + " No. Sent : " + aResult[2]);
        }

        Map<String, Object> mapResult = new HashMap<>();
        mapResult.put("result", results);
        mapResult.put("noSMS", 20);

        session.getTransaction().commit();
        return mapResult;
    }

    @Override
    public Map<String,String> smsOutGroupByUser(String startDate, String endDate) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        Criteria criteria = session.createCriteria(SMSOut.class);

        Calendar startAnotherDate = null;
        Calendar endAnotherDate = null;
        try {
            startAnotherDate = stringToCalendar(startDate);
            endAnotherDate = stringToCalendar(endDate);
        } catch (ParseException ex) {
            Logger.getLogger(SMSOutServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        /*
         * This is where the report is going to come from
         * projectionList.add(Projections.sqlGroupProjection("YEAR(time_submitted) as yearSubmitted, MONTHNAME(STR_TO_DATE(MONTH(time_submitted), '%m')) as monthSubmitted, time_submitted as timeSubmitted", "timeSubmitted", new String[] { "monthSubmitted", "timeSubmitted", "yearSubmitted" }, new Type[] { StandardBasicTypes.STRING }));
         */
        ProjectionList projectionList = Projections.projectionList();
        projectionList.add(Projections.sqlGroupProjection("YEAR(time_submitted) as yearSubmitted, MONTHNAME(STR_TO_DATE(MONTH(time_submitted), '%m')) as timeSubmitted, user as userName", "yearSubmitted, timeSubmitted, userName", new String[]{"yearSubmitted", "timeSubmitted", "userName"}, new Type[]{StandardBasicTypes.LONG, StandardBasicTypes.STRING, StandardBasicTypes.STRING}));
        projectionList.add(Projections.rowCount());
        criteria.setProjection(projectionList);
        criteria.addOrder(Order.asc("timeSubmitted"));
        criteria.add(Restrictions.between("timeSubmitted", startDate, endDate));

        List<Object[]> results = criteria.list();
        Map<String, Integer> json = new LinkedHashMap<>();
        Set<String> months = new LinkedHashSet<>();
        Set<String> users = new LinkedHashSet<>();

        while (startAnotherDate.before(endAnotherDate)) {
            String month = startAnotherDate.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());
            int year = startAnotherDate.get(Calendar.YEAR);
            for (Object[] aResult : results) {
                json.put(year + "-" + month + "-" + aResult[2], 0);
                months.add(aResult[0] + "-" + aResult[1]);
                users.add(String.valueOf(aResult[2]));
            }

            startAnotherDate.add(Calendar.MONTH, 1);
        }

        String madeUp = null;
        for (String aString : json.keySet()) {
            for (Object[] aResult : results) {
                madeUp = aResult[0] + "-" + aResult[1] + "-" + aResult[2];
                if (aString.equals(madeUp)) {
                    json.put(aString, Integer.parseInt(String.valueOf(aResult[3])));
                }
            }

        }
        StringBuilder builder = new StringBuilder();

        for (String aMonth : months) {
            builder.append("[");
            builder.append('"');
            builder.append(aMonth.substring(0, 8));
            builder.append('"');
            builder.append(',');
            for (String aString : json.keySet()) {
                if (aString.contains(aMonth)) {

                    builder.append(json.get(aString));
                    builder.append(",");
                }

            }
            builder.append("]");
            if (builder.length() > 0) {

                if (builder.charAt(builder.lastIndexOf("]") - 1) == ',') {
                    builder.deleteCharAt(builder.lastIndexOf("]") - 1);
                }
            }
            builder.append(",");
        }
        if (builder.length() > 0) {

            builder.deleteCharAt(builder.lastIndexOf(","));

        }
        StringBuilder userBuilder = new StringBuilder();
        userBuilder.append("[");
        for (String aUser : users) {

            userBuilder.append('"');
            userBuilder.append(aUser);
            userBuilder.append('"');
            userBuilder.append(',');
        }
        userBuilder.append(']');
        if (userBuilder.length() > 0) {

            if (userBuilder.charAt(userBuilder.lastIndexOf("]") - 1) == ',') {
                userBuilder.deleteCharAt(userBuilder.lastIndexOf("]") - 1);
            }
        }

        System.out.println("A new builder : " + builder.toString());
        System.out.println("The Users : " + userBuilder.toString());
        
        Map<String, String> mapResult = new HashMap<>();
        mapResult.put("data", builder.toString());
        mapResult.put("users", userBuilder.toString());

        session.getTransaction().commit();
        return mapResult;
    }

    private Calendar stringToCalendar(String string) throws ParseException {
        Date date = formatter.parse(string);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
    }

    @Override
    public String getRealSMSStatus(String smsID) {
        String toReturn = null;
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        SMSStatus smsStatus = (SMSStatus)session.load(SMSStatus.class, smsID);
        toReturn= smsStatus.getDescription();
        session.getTransaction().commit();
        return toReturn;
    }

}
