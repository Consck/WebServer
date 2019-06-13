package com.mgdb.action.lsd;

import com.mgdb.action.BaseAction;
import com.mgdb.model.po.lsd.BatteryStructure;
import com.mgdb.model.type.ResponseType;
import com.mgdb.util.ExcelUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Date;

/**
 * Created by Administrator on 2018/4/30.
 */
public class StructureExcelAction extends BaseAction {
    private File file;
    private String fileFileName;
    private String fileContentType;
    private String info_id = " ";    //拼接ID后存放的String字符串

    /**
     * EXCEL 文件数据上传
     * author:bjy
     *
     * @return
     * @throws Exception
     */
    public String excelOperate() throws Exception {
        int sigle_id;   //存放单个ID
        InputStream inp = new FileInputStream(file);
        try {
            Workbook workbook;
            try {
                workbook = ExcelUtil.getWorkbook(inp, fileFileName);
            } catch (IllegalArgumentException e) {
                return response(ResponseType.HTML, "{success:false,msg:'不是正确的EXCEL格式'}");
            }
            Sheet sheet = ExcelUtil.getSheet(workbook, 0);
            int rowNum = sheet.getLastRowNum();
            System.out.println("The whole rowNumber:     " + rowNum);
            Row row;
            int i =1;
            while(i<=rowNum) {
                row = sheet.getRow(i);
                row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                if (row.getCell(0) != null && !row.getCell(0).getStringCellValue().isEmpty()) {
                    System.out.println("00000:"+row.getCell(0).getStringCellValue());
                    int infoColumnNumber = 9;
                    String[] infoCellValue = new String[infoColumnNumber];
                    Date date = row.getCell(3).getDateCellValue();
                    for (int p = 0; p < infoColumnNumber; p++) {
                        System.out.println("p:"+p);
                        if (row.getCell(p) == null) {
                            row.createCell(p).setCellValue("");
                        }
                        row.getCell(p).setCellType(Cell.CELL_TYPE_STRING);
                        if (row.getCell(p) != null && !row.getCell(p).getStringCellValue().isEmpty()) {
                            infoCellValue[p] = row.getCell(p).getStringCellValue();
                            infoCellValue[p] = infoCellValue[p].replace("'","\\\'");
                        } else {
                            infoCellValue[p] = "";
                        }
                        System.out.println(infoCellValue[p]);
                    }

                    BatteryStructure bs = new BatteryStructure();
                    bs.setEnabled(true);
                    bs.setUploader(getLoginUserName());
                    bs.setUploadDate(new Date());
                    bs.setFile_name(infoCellValue[0]);
                    bs.setEntity_name(infoCellValue[1]);
                    bs.setMaterial_name(infoCellValue[2]);
                    bs.setExperimental_time(date);
                    bs.setExperimental_line_stand(infoCellValue[4]);
                    bs.setExperimental_type(infoCellValue[5]);
                    bs.setExperimental_conditions(infoCellValue[6]);
                    bs.setData_format(infoCellValue[7]);
                    bs.setData_article_number(infoCellValue[8]);
                    //将主表信息插入
                    sigle_id = baseService.insert(bs);
                    //对单个ID进行拼接
                    if(i == 1) {
                        info_id = sigle_id + ";";
                    }else {
                        info_id += sigle_id + ";";
                    }
                }else {
                    break;
                }
                i++;
            }
            System.out.println("基本信息录入完毕");
            System.out.println("正常录入完成");
            info_id = info_id.substring(0,info_id.length()-1);
            System.out.println("info_id = " +info_id);
            return response(ResponseType.HTML, "{success:true,msg:'success',info_id:'" + info_id + "'}");
        } catch (Exception e) {
            e.printStackTrace();
            return response(ResponseType.HTML, "{success:false,msg:'" + e.getLocalizedMessage() + "'}");
        } finally {
            if (inp != null) {
                inp.close();
            }
        }

    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public String getFileFileName() {
        return fileFileName;
    }

    public void setFileFileName(String fileFileName) {
        this.fileFileName = fileFileName;
    }

    public String getFileContentType() {
        return fileContentType;
    }

    public void setFileContentType(String fileContentType) {
        this.fileContentType = fileContentType;
    }



}
