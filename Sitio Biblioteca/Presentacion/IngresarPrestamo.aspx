<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IngresarPrestamo.aspx.cs" Inherits="IngresarPrestamo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="text-align: center" bgcolor="antiquewhite">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <strong>
        Ingresar Préstamo<br />
        </strong>
        <br />
        <table align="center">
            <tr>
                <td align="left" style="width: 155px">
                    Publicación a Prestar:</td>
                <td style="width: 153px">
                    <asp:DropDownList ID="ddlPublicaciones" runat="server" Height="25px" Width="155px">
                    </asp:DropDownList></td>
            </tr>            
            <tr>
                <td align="left" style="width: 155px">
                    Fecha de Vencimiento:</td>
                <td style="width: 151px">
                    <asp:TextBox ID="txtFecha" runat="server" Height="25px" Width="150px"></asp:TextBox></td>
            </tr>            
            <tr>
                <td align="left" style="width: 155px">
                    Nombre de Usuario:</td>
                <td style="width: 151px">
                    <asp:TextBox ID="txtUsuario" runat="server" Height="20px" Width="150px"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="height: 26px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="height: 30px">
                    <asp:Button ID="btnAgregar" runat="server" Font-Bold="True" OnClick="btnAgregar_Click"
                        Text="Agregar" Height="30px" Width="80px" /></td>
            </tr>
        </table>
    <br />
    </div>
        <asp:Label ID="lblError" runat="server"></asp:Label>
        <br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton>
    </form>
</body>
</html>
