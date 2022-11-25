<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarPublicaciones.aspx.cs" Inherits="ListarPublicaciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body bgcolor="antiquewhite">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <strong>
        Listado de Publicaciones</strong><br />
        <br />
        <div align="center">
        <asp:DropDownList ID="ddlOpciones" runat="server" AutoPostBack="True" 
                onselectedindexchanged="ddlOpciones_SelectedIndexChanged">
            <asp:ListItem Value="----------------"></asp:ListItem>
            <asp:ListItem>TODAS</asp:ListItem>
            <asp:ListItem>PAPEL</asp:ListItem>
            <asp:ListItem>DIGITAL</asp:ListItem>
            </asp:DropDownList>
        </div>
        <br />
        <asp:ListBox ID="lbPublicaciones" runat="server" Height="95px" Width="225px" style="overflow:auto" ></asp:ListBox>
        <br /><br /><br />
        <asp:TextBox ID="txtPublicaciones" runat="server" TextMode="MultiLine" Wrap="false" Rows="5" ></asp:TextBox>
        <br /><br /><br />
        <asp:Label ID="lblError" runat="server"></asp:Label><br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton></div>
    </form>
</body>
</html>
