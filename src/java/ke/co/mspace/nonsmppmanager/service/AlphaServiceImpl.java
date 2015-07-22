package ke.co.mspace.nonsmppmanager.service;

import org.hibernate.Session;

import java.util.*;
import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import ke.co.mspace.nonsmppmanager.model.Alpha;
import ke.co.mspace.nonsmppmanager.model.SMSOut;
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

/**
 *
 * @author Norrey Osako
 */
public class AlphaServiceImpl implements AlphaServiceApi {
    
    @Override
    public List<Alpha> getAllAlphanumerics() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        List<Alpha> result = session.createQuery("from Alpha").list();
        session.getTransaction().commit();
        return result;
    }
    
    @Override
    public void persistAlpha(Alpha alpha) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        session.saveOrUpdate(alpha);
        session.getTransaction().commit();
    }
    
    @Override
    public void updateAlpha(Alpha alpha) {
        
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        session.update(alpha);
        session.getTransaction().commit();
    }
    
    @Override
    public Alpha loadAlphanumericByUsername(String selectedUsername) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        Alpha alpha = new Alpha();
        List<Alpha> alphanumerics = session
                .createQuery(
                        "from Alpha c where c.username=:username")
                .setString("username", selectedUsername).list();
        if (alphanumerics.size() > 0) {
            
            alpha = alphanumerics.get(0);
            
        }
        session.getTransaction().commit();
        return alpha;
    }
    
    @Override
    public void updateAlphaByUsername(String previousUsername, String username) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        String hqlUpdate = "update Alpha c set c.username=:username where c.username=:previousUsername";
        
        int updateUser = session.createQuery(hqlUpdate)
                .setString("previousUsername", previousUsername)
                .setString("username", username)
                .executeUpdate();
        session.getTransaction().commit();
    }
    
    public void deleteAlphanumeric(Alpha aThis) {
        
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.getTransaction().begin();
        String hqlDelete = "delete Alpha c where c.username=:username";
        System.out.println("The id: " +aThis.getId());
        int updateUser = session.createQuery(hqlDelete)
                .setString("username", aThis.getUsername())                
                .executeUpdate();
        session.getTransaction().commit();
    }
    
     @Override
    public void generateXSL() {
        try {

            HSSFWorkbook wb = new HSSFWorkbook();
            Map<String, CellStyle> styles = createStyles(wb);
            HSSFSheet sheet = wb.createSheet("User_Alphanumerics_sheet_1");

            PrintSetup printSetup = sheet.getPrintSetup();
            printSetup.setLandscape(true);
            sheet.setFitToPage(true);
            sheet.setHorizontallyCenter(true);

            //title row
            Row titleRow = sheet.createRow(0);
            titleRow.setHeightInPoints(45);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("USER ALPHANUMERICS LIST");
            titleCell.setCellStyle(styles.get("title"));
            sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$B$1"));

            String[] titles = {"USERNAME", "ALPHANUMERIC"};
            HSSFRow row = sheet.createRow(1);
            row.setHeightInPoints(40);

            Cell headerCell;
            for (int i = 0; i < titles.length; i++) {
                headerCell = row.createCell(i);
                headerCell.setCellValue(titles[i]);
                headerCell.setCellStyle(styles.get("header"));
            }

            List<Alpha> alphaList = getAllAlphanumerics();
            int rowNum = 2;

            for (Alpha alpha : alphaList) {
                row = sheet.createRow(rowNum);
                row.createCell(0).setCellValue(alpha.getUsername());
                row.createCell(1).setCellValue(alpha.getName());
                
                rowNum++;
            }

            sheet.setColumnWidth(0, 20 * 256); //30 characters wide
            sheet.setColumnWidth(1, 20 * 256);
            

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
    
}
