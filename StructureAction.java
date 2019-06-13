package com.mgdb.action.lsd;

import com.mgdb.action.BaseAction;
import com.mgdb.action.NumberOfDataInterface;
import com.mgdb.model.common.ListResult;
import com.mgdb.model.po.Role;
import com.mgdb.model.po.User;
import com.mgdb.model.po.lsd.BatteryStructure;
import com.mgdb.service.BaseService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.net.URLDecoder;
import java.util.Set;


@SuppressWarnings("serial")
public class StructureAction extends BaseAction implements NumberOfDataInterface  {
    private String jsonString;
    private int id;
    /**
     * 根据查询条件返回所有数据
     * @Created by bjy
     * @return
     * @throws Exception
     */
    public String listAll() throws Exception{
        try{
            int start=rows*(page-1);
            int end=start+rows;
            DetachedCriteria dc;
            if(jsonString!=null){
                dc = DetachedCriteria.forClass(BatteryStructure.class);
                JSONArray jsonBasicInfoArray = JSONArray.fromObject(URLDecoder.decode(jsonString,"UTF-8"));
                //取得第一层json数据
                JSONObject jsonBasicInfo = jsonBasicInfoArray.getJSONObject(0);
                System.out.println(jsonBasicInfo.toString());
                if(jsonBasicInfo.has("material_name")){
                    dc.add(Restrictions.like("material_name", "%" + jsonBasicInfo.getString("material_name") + "%"));
                }

                dc.add(Restrictions.eq("enabled", true));
            }else{
                dc = DetachedCriteria.forClass(BatteryStructure.class);
                dc.add(Restrictions.eq("enabled", true));
            }
            ListResult<BatteryStructure> list = baseService.queryAllByPage(dc, rows, page);
            System.out.println(list.toJson().replace("null", "").replace("\n", ""));
            return response(list.toJson().replace("null", "").replace("\n", ""));
        }catch (Exception ex){
            System.out.println("error--------->"+ex.getLocalizedMessage());
            return response("{success:false}");
        }
    }

    /**
     * 按ID返回指定材料数据
     * @Created by bjy
     * @return
     * @throws Exception
     */
    public String listById() throws Exception{
        System.out.println("111111111111111111111111111111");
        try{
            DetachedCriteria dc  = DetachedCriteria.forClass(BatteryStructure.class);
            dc.add(Restrictions.eq("id",id));
            ListResult<BatteryStructure> BatteryStructure = baseService.queryAll(dc);
            System.out.println("BatteryStructure------" + BatteryStructure.toJson());
            return response(BatteryStructure.toJson().replace("null", ""));
        }catch (Exception ex){
            System.out.println("error--------->"+ex.getLocalizedMessage());
            return response("{success:false}");
        }
    }


    /***
     * 查询用户上传权限
     * @return
     */
    public String checkUploadPermission() throws Exception{
        DetachedCriteria dc = DetachedCriteria.forClass(User.class);
        dc.add(Restrictions.eq("username",getLoginUserName()));
        ListResult<User> userList = baseService.queryAll(dc);
        User user = userList.getRoot().get(0);
        Set<Role> roleSet = user.getRolelist();
        for(Role role : roleSet){
            if(role.getName().equals("ROLE_ADMIN")){
                return response("{success:true, totalProperty:0,currentPage:1,pageNum:0,root:[]}");
            }
        }
        return response("{success:false, totalProperty:0,currentPage:1,pageNum:0,root:[]}");
    }

    public String getJsonString() {
        return jsonString;
    }
    public void setJsonString(String jsonString) {
        this.jsonString = jsonString;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    @Override
    public String getNumberOfData(BaseService thisBaseService) {
        String databaseName = "光源数据库";//修改数据库名称
        int number = thisBaseService.getCount(BatteryStructure.class);
        return "{name:\""+databaseName+"\",num:"+number+"}";
    }


    /**
     * 下载文件****************************************************
     * @return
     */
    /*
    public String downloadFile(){
        String path = getRealPath()+"/upload/battery_structure"+fileUrl;
        HttpServletResponse response = ServletActionContext.getResponse();
        String [] fileNames = fileUrl.split("/");
        String fileName = fileNames[fileNames.length-1];
        try {
            // path是指欲下载的文件的路径。
            File file = new File(path);
            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            String filenameString = new String(fileName.getBytes("gbk"),"iso-8859-1");
            response.addHeader("Content-Disposition", "attachment;filename="+ filenameString);
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response
                    .getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    */
}
