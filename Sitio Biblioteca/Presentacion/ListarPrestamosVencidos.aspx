<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarPrestamosVencidos.aspx.cs" Inherits="ListarPrestamosVencidos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body bgcolor="antiquewhite">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <strong>
        Listado de Préstamos Vencidos<br />
        <br />
        <br />
        <asp:Label ID="lblFecha" runat="server" Text="Ingrese una fecha"></asp:Label>
        <br />
        <asp:TextBox ID="txtFecha" runat="server" style="margin-top: 0px" 
            ></asp:TextBox>
        <br />
        </strong>
        <br />
        <asp:ListBox ID="lbPrestamos" runat="server" Height="312px" Width="700px" style="overflow:auto"></asp:ListBox><br />
        <br />
        <asp:Button ID="btnConsultar" runat="server" onclick="btnConsultar_Click" 
            Text="Consultar" />
        <br />
        <br />
        <asp:Label ID="lblError" runat="server"></asp:Label><br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton></div>
    </form>
</body>
</html>
