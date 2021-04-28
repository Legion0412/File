/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package qldb;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.event.*;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.JOptionPane;
/**
 *
 * @author Admin
 */
public class Login extends JFrame{

    private JTextField tfUsername;
    private JPasswordField tfPassword;
    private JButton btnDN, btnDK;
    private JCheckBox showPassword;

    public Login() {
        super("Chương trình quản lý danh bạ");
        initComponents();
        handle();
    }

    private void initComponents() {
        tfUsername = new JTextField(20);
        tfPassword = new JPasswordField(20);
        btnDN = new JButton("Đăng Nhập");
        btnDK = new JButton("Đăng Ký");
        showPassword = new JCheckBox("Show Password");

        this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        this.setSize(450, 300);
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setIconImage(java.awt.Toolkit.getDefaultToolkit().getImage(Main.iconImage));

        Container con = getContentPane();
        con.setLayout(new BorderLayout());


        JPanel pnTitle = new JPanel(new FlowLayout());
        JLabel lbTitle = new JLabel("Login");
        lbTitle.setFont(new Font("Tahoma", Font.BOLD, 46));
        lbTitle.setForeground(Color.CYAN);
        pnTitle.add(lbTitle);
        pnTitle.setPreferredSize(new Dimension(0, 90));

        JPanel pnContent = new JPanel();
        pnContent.setLayout(new BoxLayout(pnContent, BoxLayout.Y_AXIS));

        JPanel pnUsername = new JPanel(new FlowLayout());
        JLabel lbUsername = new JLabel("Username:   ");
        pnUsername.add(lbUsername);
        pnUsername.add(tfUsername);

        JPanel pnPassword = new JPanel(new FlowLayout());
        JLabel lbPassword = new JLabel("Password:   ");
        pnPassword.add(lbPassword);
        pnPassword.add(tfPassword);

        JPanel pnResPass = new JPanel(new FlowLayout());
        showPassword.setCursor(new Cursor(Cursor.HAND_CURSOR));
        pnResPass.add(showPassword);

        pnContent.add(pnUsername);
        pnContent.add(pnPassword);
        pnContent.add(pnResPass);

        JPanel pnFooter = new JPanel(new FlowLayout());
        btnDK.setCursor(new Cursor(Cursor.HAND_CURSOR));
        btnDN.setCursor(new Cursor(Cursor.HAND_CURSOR));
        pnFooter.add(btnDN);
        pnFooter.add(btnDK);
        pnFooter.setPreferredSize(new Dimension(0, 60));

        // set background
        pnTitle.setBackground(Color.WHITE);
        pnUsername.setBackground(Color.WHITE);
        pnPassword.setBackground(Color.WHITE);
        pnFooter.setBackground(Color.WHITE);
        pnResPass.setBackground(Color.WHITE);
        showPassword.setBackground(Color.WHITE);

        con.add(pnTitle, BorderLayout.PAGE_START);
        con.add(pnContent, BorderLayout.CENTER);
        con.add(pnFooter, BorderLayout.PAGE_END);
    }

    private void checkLogin() {
        String username = tfUsername.getText().trim();
        String pwd = tfPassword.getText().trim();

        String u = "admin";
        String p = "1234";

        if(username.equals("") || pwd.equals("")) {
            if(pwd.equals(""))
                tfPassword.requestFocus();
            if(username.equals(""))
                tfUsername.requestFocus();
            JOptionPane.showMessageDialog(null, "Hãy nhập đủ thông tin đăng nhập", "Thông Báo", JOptionPane.WARNING_MESSAGE);
            return;
        }
        // xử lý kiểm tra đăng nhập
        if(!username.equals(u) || !pwd.equals(p)) {
            JOptionPane.showMessageDialog(null, "Thông tin đăng nhập không chính xác", "Thông Báo", JOptionPane.WARNING_MESSAGE);
            tfUsername.requestFocus();
            tfUsername.selectAll();
            return;
        }
        try {
          FileOutputStream fos = new FileOutputStream(Main.saoLuuDangNhap);
          OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
          BufferedWriter bw = new BufferedWriter(osw);
          bw.write(username+"-"+pwd);
          bw.close();
          osw.close();
          fos.close();
        } catch(Exception e) {
          e.printStackTrace();
        }

        new DanhBa_GUI().setVisible(true);
        dispose();
    }

    private void handle() {
        tfUsername.addKeyListener(new KeyListener(){

            @Override
            public void keyTyped(KeyEvent e) {

            }

            @Override
            public void keyReleased(KeyEvent e) {

            }

            @Override
            public void keyPressed(KeyEvent e) {
                if(e.getKeyChar() == KeyEvent.VK_ENTER) {
                    checkLogin();
                }
            }
        });
        tfPassword.addKeyListener(new KeyListener(){

          @Override
          public void keyTyped(KeyEvent e) {

          }

          @Override
          public void keyReleased(KeyEvent e) {

          }

          @Override
          public void keyPressed(KeyEvent e) {
            if(e.getKeyChar() == KeyEvent.VK_ENTER) {
              checkLogin();
            }
          }
        });
        btnDN.addActionListener(ae -> {
            checkLogin();
        });
        btnDK.addActionListener(ae -> {
            new DangKy(this, true).setVisible(true);
            this.tfPassword.setText("");
            this.tfUsername.setText("");
            this.tfUsername.requestFocus();
        });
        showPassword.addActionListener(ae -> {
            if (showPassword.isSelected())
                tfPassword.setEchoChar((char)0);
            else tfPassword.setEchoChar('•');
        });
    }

}
