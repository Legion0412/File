/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package qldb;

/**
 *
 * @author pc
 */
public class NguoiDung {
    private String maND, tenND, email, gioiTinh;
    private DangNhap dn;

    /**
     * @return the maND
     */
    public String getMaND() {
        return maND;
    }

    /**
     * @param maND the maND to set
     */
    public void setMaND(String maND) {
        this.maND = maND;
    }

    /**
     * @return the tenND
     */
    public String getTenND() {
        return tenND;
    }

    /**
     * @param tenND the tenND to set
     */
    public void setTenND(String tenND) {
        this.tenND = tenND;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
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
     * @return the dn
     */
    public DangNhap getDn() {
        return dn;
    }

    /**
     * @param dn the dn to set
     */
    public void setDn(DangNhap dn) {
        this.dn = dn;
    }

    public NguoiDung() {
    }

    public NguoiDung(String maND, String tenND, String email, String gioiTinh) {
        this.maND = maND;
        this.tenND = tenND;
        this.email = email;
        this.gioiTinh = gioiTinh;
    }

    @Override
    public String toString() {
        return this.tenND; //To change body of generated methods, choose Tools | Templates.
    }
    
}