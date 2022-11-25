<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="text-align: justify">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <strong><span style="font-size: 14pt">Introducción a ADO.NET - Desconectado</span></strong><br />
        <br />
        <table border="1" align="center">
            <tr>
                <td style="width: 355px; text-align: center">
                    <asp:LinkButton ID="lnkBtnListar" runat="server" 
                        PostBackUrl="~/ListarEmpdeEmpresa.aspx">Listado de los Empleados de una Empresa</asp:LinkButton></td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td style="width: 355px">
                    <asp:LinkButton ID="lnkBtnModificar" runat="server" 
                        PostBackUrl="~/EjemploDataSet.aspx">Modificar datos Desde Grilla</asp:LinkButton></td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td style="width: 355px">
                    <asp:LinkButton ID="lnkBtnBuscar" runat="server" 
                        PostBackUrl="~/BuscarEmpleado.aspx">Buscar Datos</asp:LinkButton></td>
            </tr>
            </table>
    
    </div>
        <br />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
