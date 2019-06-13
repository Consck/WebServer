package com.mgdb.model.po.lsd;

/**
 * Created by bjy on 2018/4/29.
 * 原位电池结构研究
 */
import com.mgdb.model.common.JsonEntity;
import com.mgdb.model.po.BaseEntity;
import javax.persistence.*;
import java.util.*;


@SuppressWarnings("serial")
@Entity
@Table(name = "a_bs")
public class BatteryStructure implements BaseEntity,JsonEntity{
    private int id;
    private String file_name;//文件名称
    private String entity_name;//单位名称
    private String material_name;//材料名称
    private Date experimental_time;//实验时间
    private String experimental_line_stand;//实验线站
    private String experimental_type;//实验类型
    private String experimental_conditions;//实验条件
    private String data_format;//数据格式
    private String data_article_number;//数据条数
    private String uploader;//上传者
    private Date uploadDate;//上传日期
    private boolean enabled;//删除标志位
    public String toJson() {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("id:").append(id).append(",");
        sb.append("file_name:'").append(file_name).append("',");
        sb.append("entity_name:'").append(entity_name).append("',");
        sb.append("material_name:'").append(material_name).append("',");
        sb.append("experimental_time:'").append(experimental_time).append("',");
        sb.append("experimental_line_stand:'").append(experimental_line_stand).append("',");
        sb.append("experimental_type:'").append(experimental_type).append("',");
        sb.append("experimental_conditions:'").append(experimental_conditions).append("',");
        sb.append("data_format:'").append(data_format).append("',");
        sb.append("data_article_number:'").append(data_article_number).append("',");
        sb.append("uploader:'").append(uploader).append("',");
        sb.append("uploadDate:'").append(uploadDate).append("',");
        sb.append("enabled:'").append(enabled).append("'");
        sb.append("}");
        return sb.toString();
    }

    @Override
    public Map<String, Object> toMap() {
        return null;
    }

    @Override
    @Id
    @GeneratedValue
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getEntity_name() {
        return entity_name;
    }

    public void setEntity_name(String entity_name) {
        this.entity_name = entity_name;
    }

    public String getMaterial_name() {
        return material_name;
    }

    public void setMaterial_name(String material_name) {
        this.material_name = material_name;
    }

    public String getUploader() {
        return uploader;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public Date getExperimental_time() {
        return experimental_time;
    }

    public void setExperimental_time(Date experimental_time) {
        this.experimental_time = experimental_time;
    }

    public String getExperimental_line_stand() {
        return experimental_line_stand;
    }

    public void setExperimental_line_stand(String experimental_line_stand) {
        this.experimental_line_stand = experimental_line_stand;
    }

    public String getExperimental_type() {
        return experimental_type;
    }

    public void setExperimental_type(String experimental_type) {
        this.experimental_type = experimental_type;
    }

    public String getExperimental_conditions() {
        return experimental_conditions;
    }

    public void setExperimental_conditions(String experimental_conditions) {
        this.experimental_conditions = experimental_conditions;
    }

    public String getData_format() {
        return data_format;
    }

    public void setData_format(String data_format) {
        this.data_format = data_format;
    }

    public String getData_article_number() {
        return data_article_number;
    }

    public void setData_article_number(String data_article_number) {
        this.data_article_number = data_article_number;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }


}



