/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dto;

/**
 *
 * @author LAB-USR-LNORTE
 */
public class Cliente {
    private int idCliente;
    private String Dni;
    private String Nombres;
    private String Direccion;
    private String Email;
    private String Password;

    public Cliente(int idCliente, String Dni, String Nombres, String Direccion, String Email, String Password) {
        this.idCliente = idCliente;
        this.Dni = Dni;
        this.Nombres = Nombres;
        this.Direccion = Direccion;
        this.Email = Email;
        this.Password = Password;
    }

    public Cliente() {
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getDni() {
        return Dni;
    }

    public void setDni(String Dni) {
        this.Dni = Dni;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    @Override
    public String toString() {
        return getNombres();
    }
    
}
