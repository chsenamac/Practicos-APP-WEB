<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ABMPublicacionPapel.aspx.cs" Inherits="ABMPublicacionPapel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .style3
        {
            width: 94px;
            height: 21px;
            font-weight: normal;
        }
        .style4
        {
            font-weight: normal;
        }
    </style>
</head>
<body bgcolor="#faebd8">
    <form id="form2" runat="server">
    <div style="text-align: center; height: 309px">
    
        <strong>Mantenimiento Publicación Papel</strong><br />
        <br />
        <table align="center" style="width: 32%;">
            <tr>
                <td class="style3">
                    ISBN:</td>
                <td>
                    <asp:TextBox ID="txtISBN" runat="server"></asp:TextBox>
                </td>
                <td align="center" style="width: 100px; height: 21px">
                    <asp:Button ID="btnBuscar" runat="server" Font-Bold="True" Text="Buscar" 
                        onclick="btnBuscar_Click" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    Título:</td>
                <td>
                    <asp:TextBox ID="txtTitulo" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style4">
                    Peso:</td>
                <td>
                    <asp:TextBox ID="txtPeso" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style1" colspan="2">
                    <asp:Button ID="btnAgregar" runat="server" Font-Bold="True" Text="Agregar" 
                        onclick="btnAgregar_Click" />
                    <asp:Button ID="btnModificar" runat="server" Font-Bold="True" 
                        Text="Modificar" onclick="btnModificar_Click" />
                    <asp:Button ID="btnEliminar" runat="server" Font-Bold="True" Text="Eliminar" 
                        onclick="btnEliminar_Click" />
                </td>
                <td class="style1">
                    <asp:Button ID="btnLimpiar" runat="server" Font-Bold="True" Text="Limpiar" 
                        onclick="btnLimpiar_Click" />
                </td>
            </tr>
            </table>
        <br />
        <br />
        <asp:Label ID="lblError" runat="server" Font-Bold="False"></asp:Label>
        <br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" Font-Bold="False" 
            PostBackUrl="~/Default.aspx">Volver</asp:LinkButton>
    
    </div>
    </form>
</body>
</html>
