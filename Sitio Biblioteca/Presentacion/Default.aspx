<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body bgcolor="antiquewhite">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <span style="font-size: 11pt; line-height: 115%; font-family: 'Calibri','sans-serif';">
            <strong>PÁGINA PRINCIPAL</strong>
            <br />
            <br />
            <asp:LinkButton ID="lnkBtnABMPD" runat="server" PostBackUrl="~/ABMPublicacionDigital.aspx">ABM Publicación Digital</asp:LinkButton><br />            
            <asp:LinkButton ID="lnkBtnABMPP" runat="server" PostBackUrl="~/ABMPublicacionPapel.aspx">ABM Publicación Papel</asp:LinkButton><br />
            <br />
            <asp:LinkButton ID="lnkBtnIP" runat="server" PostBackUrl="~/IngresarPrestamo.aspx">Ingresar Préstamo</asp:LinkButton><br />
            <asp:LinkButton ID="lnkBtnDP" runat="server" PostBackUrl="~/DevolverPublicacion.aspx">Devolver Préstamo</asp:LinkButton><br />
            <br />
            <asp:LinkButton ID="lnkBtnLTPR" runat="server" PostBackUrl="~/ListarTodosLosPrestamos.aspx">Listar Todos los Préstamos</asp:LinkButton><br />
            <asp:LinkButton ID="lnkBtnLPV" runat="server" PostBackUrl="~/ListarPrestamosVencidos.aspx">Listar Préstamos Vencidos</asp:LinkButton><br />                  
            <asp:LinkButton ID="lnkBtnLTPU" runat="server" PostBackUrl="~/ListarPublicaciones.aspx">Listar Todas las Publicaciones</asp:LinkButton><br />
            <br />
            <asp:LinkButton ID="lnkBtnPE" runat="server" PostBackUrl="~/Libro">Prueba de Error No Existe la Página</asp:LinkButton>
            <br />
            <br />
            <asp:LinkButton ID="lnkBtnEGC" runat="server" PostBackUrl="~/EjemploCompletoGrilla.aspx">Ejemplo Grillas y Colecciones</asp:LinkButton><br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </span>
    </div>
    </form>
</body>
</html>
