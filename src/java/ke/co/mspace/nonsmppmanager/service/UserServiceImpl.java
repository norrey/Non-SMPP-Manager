package ke.co.mspace.nonsmppmanager.service;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.hibernate.Session;

import ke.co.mspace.nonsmppmanager.model.User;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import ke.co.mspace.nonsmppmanager.util.HibernateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.criterion.Projections;

/**
 *
 * @author Norrey Osako
 */
public class UserServiceImpl implements UserServiceApi {

    @Override
    public List<User> getAllUsers() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        List<User> result = session.createQuery("from User c where c.admin=:admin").setCharacter("admin", '2').list();
        session.getTransaction().commit();
        return result;
    }

    @Override
    public void persistUser(User user) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();

        session.getTransaction().begin();
        session.save(user);
        session.getTransaction().commit();
    }

    @Override
    public Date setEndDate() {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String endDateInString = "2099-12-31 00:00:00";
        Date endDate = null;
        try {
            endDate = simpleDateFormat.parse(endDateInString);
        } catch (ParseException ex) {
            Logger.getLogger(UserServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return endDate;
    }

    @Override
    public boolean authenticateUser(String username, String password) {

        boolean authenticated = false;
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        List<User> users = session
                .createQuery(
                        "from User c where c.username=:username and c.password=:password and c.admin=:admin")
                .setString("username", username).setString("password", password).setCharacter("admin", '1').list();
        if (users.size() > 0) {
            authenticated = true;
        }
        session.getTransaction().commit();
        return authenticated;
    }

    @Override
    public void updateUser(User user) {

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        session.update(user);
        session.getTransaction().commit();
    }

    @Override
    public User loadCustomerByUsername(String selectedUsername) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        User user = null;
        List<User> users = session
                .createQuery(
                        "from User c where c.username=:username")
                .setString("username", selectedUsername).list();
        if (users.size() > 0) {

            user = users.get(0);

        }
        session.getTransaction().commit();
        return user;
    }

    @Override
    public void generateXSL() {
        try {
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("Users_Sheet1");

            HSSFRow row = sheet.createRow(0);
            row.createCell(0).setCellValue("USERNAME");
            row.createCell(1).setCellValue("SMS CREDITS");
            row.createCell(2).setCellValue("ORGANIZATION");
            row.createCell(3).setCellValue("MOBILE");
            row.createCell(4).setCellValue("EMAIL");

            List<User> exportUsers = getAllUsers();
            int rowNum = 1;
            for (User aUser : exportUsers) {
                row = sheet.createRow(rowNum);
                row.createCell(0).setCellValue(aUser.getUsername());
                row.createCell(1).setCellValue(aUser.getSmsCredits());
                row.createCell(2).setCellValue(aUser.getOrganization());
                row.createCell(3).setCellValue(aUser.getUserMobile());
                row.createCell(4).setCellValue(aUser.getUserEmail());
                rowNum++;
            }

            Map<String, Object> stats = simpleStatistics();
            row = sheet.createRow(rowNum + 3);
            row.createCell(0).setCellValue("Total Number of Users :");
            row.createCell(1).setCellValue(stats.get("numberOfUsers").toString());

            row = sheet.createRow(rowNum + 4);
            row.createCell(0).setCellValue("Total Number SMS Credits Awarded :");
            row.createCell(1).setCellValue(stats.get("totalCreditsAssigned").toString());

            row = sheet.createRow(rowNum + 5);
            row.createCell(0).setCellValue("Highest Number of SMS Credits Awarded :");
            row.createCell(1).setCellValue(stats.get("highestCreditAwarded").toString());

            row = sheet.createRow(rowNum + 6);
            row.createCell(0).setCellValue("Lowest Number of SMS Credits Awarded :");
            row.createCell(1).setCellValue(stats.get("lowestCreditAwarded").toString());

            row = sheet.createRow(rowNum + 7);
            row.createCell(0).setCellValue("Average Number of SMS Credits Awarded :");
            row.createCell(1).setCellValue(stats.get("averageCreditAwarded").toString());

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
    public Map<String, Object> simpleStatistics() {
        Long numberOfUsers = 0L;
        Long totalCreditsAssigned = 0L;
        int lowestCreditAwarded = 0;
        int highestCreditAwarded = 0;
        float averageCreditAwarded = 0f;

        Map<String, Object> statistics = new HashMap<String, Object>();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();

        numberOfUsers = (Long) session.createCriteria(User.class).setProjection(Projections.rowCount()).uniqueResult();

        Query maximumCreditQuery = session.createQuery("SELECT MAX(smsCredits) FROM User");

        for (Iterator it = maximumCreditQuery.iterate(); it.hasNext();) {
            highestCreditAwarded = (int) it.next();

        }

        Query lowestCreditQuery = session.createQuery("SELECT MIN(smsCredits) FROM User");

        for (Iterator it = lowestCreditQuery.iterate(); it.hasNext();) {
            lowestCreditAwarded = (int) it.next();

        }

        Query sumCredits = session.createQuery("SELECT SUM(smsCredits) FROM User");

        for (Iterator it = sumCredits.iterate(); it.hasNext();) {
            totalCreditsAssigned = (Long) it.next();

        }
        averageCreditAwarded = ((float) totalCreditsAssigned) / numberOfUsers;

        statistics.put("numberOfUsers", numberOfUsers);
        statistics.put("totalCreditsAssigned", totalCreditsAssigned);
        statistics.put("highestCreditAwarded", highestCreditAwarded);
        statistics.put("lowestCreditAwarded", lowestCreditAwarded);
        statistics.put("averageCreditAwarded", String.format("%.2f", averageCreditAwarded));

        session.getTransaction().commit();

        return statistics;
    }

    @Override
    public void generatePDF() throws IOException, DocumentException {

        FacesContext context = FacesContext.getCurrentInstance();
        HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline=filename=file.pdf");

        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        document.open();
        document.add(createPdfTable());
        document.close();

        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");
        response.setHeader("Content-disposition", "attachment; filename=users.pdf");
        response.setContentType("application/pdf");
        response.setContentLength(baos.size());

        OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();
        context.responseComplete();

    }

    public PdfPTable createPdfTable() {
        PdfPTable table = new PdfPTable(5);

        PdfPCell cell;
        cell = new PdfPCell(new Phrase("SMPP Users Table"));
        cell.setColspan(5);
        table.addCell(cell);

        table.addCell("USERNAME");
        table.addCell("SMS CREDITS");
        table.addCell("ORGANIZATION");
        table.addCell("MOBILE");
        table.addCell("EMAIL");

        List<User> exportUsers = getAllUsers();

        for (User aUser : exportUsers) {

            table.addCell(aUser.getUsername());
            table.addCell("" + aUser.getSmsCredits());
            table.addCell(aUser.getOrganization());
            table.addCell(aUser.getUserMobile());
            table.addCell(aUser.getUserEmail());

        }

        return table;
    }

    @Override
    public void updateCredits(String username, int smsCredits) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        String hqlUpdate = "update User c set c.smsCredits = :smsCredits where c.username = :username";

        int updateUser = session.createQuery(hqlUpdate)
                .setInteger("smsCredits", smsCredits)
                .setString("username", username)
                .executeUpdate();
        session.getTransaction().commit();

    }
    
    public void updateAlpha(String usernameOld, String usernameNew){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        String hqlUpdate = "update Alpha c set c.username = :usernameNew where c.username = :usernameOld";

        int updateUser = session.createQuery(hqlUpdate)
                .setString("usernameOld", usernameOld)
                .setString("usernameNew", usernameNew)
                .executeUpdate();
        session.getTransaction().commit();
        
    }

}
