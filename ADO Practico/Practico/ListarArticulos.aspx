<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarArticulos.aspx.cs" Inherits="ListarArticulos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página sin título</title>
    <style type="text/css">
        .style1
        {
            color: #000000;
            font-weight: bold;
        }
        .style2
        {
            text-align: center;
        }
    </style>
</head>
<!--body bgcolor="#ffe1c1"-->
<body bgcolor="#ffffff">
    <form id="form1" runat="server">
    <div align="center">
        <span class="style1">LISTADO COMPLETO DE ARTICULOS<br />
        <br />
        </span><br />    
    <asp:GridView ID="gvListado" runat="server" 
        Height="197px" Width="456px" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField HeaderText="CODIGO" DataField="CodArt" />
            <asp:BoundField HeaderText="NOMBRE" DataField="NomArt" />
            <asp:BoundField HeaderText="PRECIO" DataField="PreArt" />
        </Columns>
        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:GridView>
    </div>
    <p>
        &nbsp;</p>
    <p style="text-align: center">
        <asp:Label ID="lblError" runat="server" ForeColor="Red" 
            style="text-align: center" Width="386px"></asp:Label>
    </p>
    <p style="text-align: center">
        <asp:LinkButton ID="lnkbtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton>
    </p>
    </form>
</body>
</html>
