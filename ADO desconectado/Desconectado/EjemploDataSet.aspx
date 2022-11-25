<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EjemploDataSet.aspx.cs" Inherits="EjemploDataSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <strong><asp:Label ID="lblTitulo" runat="server"></asp:Label>
        </strong>
        <br />
        <br />
        <asp:GridView ID="gvEmpleado" runat="server" Height="133px" Width="382px" 
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
            GridLines="None" onrowcommand="gvEmpleado_CommandRow">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="cedula" HeaderText="CEDULA" />
                <asp:BoundField DataField="nombre" HeaderText="NOMBRE" />
                <asp:BoundField DataField="edad" HeaderText="EDAD" />
                <asp:ButtonField ButtonType="Button" CommandName="Sumar" Text="SUMAR" />
                <asp:ButtonField ButtonType="Button" CommandName="Restar" Text="RESTAR" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <br />
        <asp:Button ID="btnListar" runat="server" Font-Bold="True" OnClick="btnCargar_Click"
            Text="Listar Empleados" Width="200px" />        
        <br />
        <br />
        <asp:Button ID="btnActualizar" runat="server" Font-Bold="True" 
            Text="Actualizar BD" Width="200px" OnClick="btnActualizar_Click" />&nbsp;<br />
        <br />
        <asp:Label ID="lblError" runat="server"></asp:Label><br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton></div>
    </form>
</body>
</html>
