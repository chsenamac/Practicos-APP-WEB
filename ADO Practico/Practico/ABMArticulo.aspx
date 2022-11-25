<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ABMArticulo.aspx.cs" Inherits="ABMArticulo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página sin título</title>
    <style type="text/css">
        .style1
        {
            text-align: center;
        }
        .style2
        {
            color: #000000;
            font-weight: bold;
        }
    </style>
</head>
<!--body bgcolor="#ffe1c1"-->
<body bgcolor="#ffffff">
    <form id="form1" runat="server">
    <div align="center">
        <span class="style2">ALTA DE ARTICULOS</span><br />
        <br />
           <table border="1">
        <tr>
            <td> Codigo: </td>
            <td><asp:TextBox ID="txtCodigo" runat="server"></asp:TextBox></td>
            <td align="center"><asp:Button ID="BtnBuscar" runat="server" Text="Buscar" 
                    onclick="BtnBuscar_Click" /></td>
        </tr>
        <tr>
            <td> Nombre: </td>
            <td>  <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox> </td>
            <td align="center"> 
                <asp:Button ID="BtnLimpiar" runat="server" onclick="BtnLimpiar_Click" 
                    Text="Limpiar" />
            </td>
        </tr>
        <tr>
            <td> Precio: </td>
            <td> <asp:TextBox ID="txtPrecio" runat="server"></asp:TextBox> </td>
            <td>  &nbsp; </td>        
        </tr>
        <tr>
            <td align="center"><asp:Button ID="BtnAlta" runat="server" Text="Alta" Enabled="False" 
                    onclick="BtnAlta_Click" /></td>
            <td align="center"><asp:Button ID="BtnBaja" runat="server" Text="Baja" Enabled="False" 
                    onclick="BtnBaja_Click" /></td>
            <td align="center"><asp:Button ID="BtnModificar" runat="server" Text="Modificar" Enabled="False" 
                    onclick="BtnModificar_Click" /></td>
        </tr>
        <tr>
            <td colspan="3">  &nbsp;  </td>
        </tr>
        <tr>
            <td colspan="3"> &nbsp;<asp:Label ID="lblError" runat="server" ForeColor="Red" Width="228px"></asp:Label></td>
        </tr>
        </table>
        <br />
        &nbsp;<br />
        <asp:LinkButton ID="lnkbtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton>
    </div>
    </form>
</body>
</html>
