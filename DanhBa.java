/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package qldb;

import java.util.Date;
import java.util.Vector;

/**
 *
 * @author pc
 */
public class DanhBa {
   private String msDB, sdt, tenLH,gioiTinh,ghiChu,Email;
   private Date NgayLuu;
   private NhomLienHe nlh;
    /**
     * @return the msDB
     */
    public String getMsDB() {
        return msDB;
    }

    /**
     * @param msDB the msDB to set
     */
    public void setMsDB(String msDB) {
        this.msDB = msDB;
    }

    /**
     * @return the sdt
     */
    public String getSdt() {
        return sdt;
    }

    /**
     * @param sdt the sdt to set
     */
    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    /**
     * @return the tenLH
     */
    public String getTenLH() {
        return tenLH;
    }

    /**
     * @param tenLH the tenLH to set
     */
    public void setTenLH(String tenLH) {
        this.tenLH = tenLH;
    }

    /**
     * @return the gioiTinh
     */
    public String getGioiTinh() {
        return gioiTinh;
    }

    /**
     * @param gioiTinh the gioiTinh to set
     */
    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    /**
     * @return the ghiChu
     */
    public String getGhiChu() {
        return ghiChu;
    }

    /**
     * @param ghiChu the ghiChu to set
     */
    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    /**
     * @return the NgayLuu
     */
    public Date getNgayLuu() {
        return NgayLuu;
    }

    /**
     * @param NgayLuu the NgayLuu to set
     */
    public void setNgayLuu(Date NgayLuu) {
        this.NgayLuu = NgayLuu;
    }

  /**
     * @return the nlh
     */
    public NhomLienHe getNlh() {
        return nlh;
    }

    /**
     * @param nlh the nlh to set
     */
    public void setNlh(NhomLienHe nlh) {
        this.nlh = nlh;
    }

        /**
     * @return the Email
     */
    public String getEmail() {
        return Email;
    }

    /**
     * @param Email the Email to set
     */
    public void setEmail(String Email) {
        this.Email = Email;
    }
    
    public DanhBa() {
    }

    public DanhBa(String msDB, String sdt, String tenLH, String gioiTinh, String ghiChu, String Email, Date NgayLuu) {
        this.msDB = msDB;
        this.sdt = sdt;
        this.tenLH = tenLH;
        this.gioiTinh = gioiTinh;
        this.ghiChu = ghiChu;
        this.Email = Email;
        this.NgayLuu = NgayLuu;
    }


    @Override
    public String toString() {
        return this.tenLH; //To change body of generated methods, choose Tools | Templates.
    }


}