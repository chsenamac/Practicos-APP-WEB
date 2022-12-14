<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EjemploCompletoGrilla.aspx.cs" Inherits="EjemploCompletoGrilla" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body bgcolor="antiquewhite">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <strong>Ejemplo Completo de Grilla</strong><br />
        <br />
        <br />
        <table align="center" style="width: 600px" border="1">
            <tr>
                <td style="width: 211px">
                    Grilla Completa con Todas las Publicaciones (GVCompleto)</td>
                <td style="width: 482px">
                    <asp:GridView ID="gvCompleto" runat="server" Width="427px">
                        <SelectedRowStyle BackColor="Fuchsia" />
                    </asp:GridView>
                    <br />
                    <asp:Button ID="btnVer" runat="server" OnClick="btnVer_Click" Text="Usar Seleccion" />
                    &nbsp;<asp:Button ID="btnBorrar" runat="server" OnClick="btnBorrar_Click" Text="Borrar Seleccion" />&nbsp;<br />
                    <br />
                    <asp:Button ID="btnCopiar" runat="server" OnClick="btnCopiar_Click" Text="Agregar a Seleccionadas" /><br />
                </td>
            </tr>
            <tr>
                <td style="width: 211px; height: 59px">
                    Grilla con las Publicaciones Seleccionadas (GVSeleccion)</td>
                <td style="width: 482px; height: 59px">
                    <asp:GridView ID="gvSeleccion" runat="server" 
                        Width="212px">
                    </asp:GridView>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 211px">
                </td>
                <td style="width: 482px">
                    <asp:Label ID="lblError" runat="server" Width="400px"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 211px">
                </td>
                <td style="width: 482px">
                    <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
