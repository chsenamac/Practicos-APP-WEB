<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarEmpdeEmpresa.aspx.cs" Inherits="ListarEmpdeEmpresa" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <strong>Listado de Empleados de una Empresa</strong><br />
        <br />
        Empresa:&nbsp;
        <asp:DropDownList ID="ddlEmpresa" runat="server" Width="350px"
            OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" Enabled="False" 
            AutoPostBack="True">
        </asp:DropDownList>
        <br />        
        <br />
        <asp:GridView ID="gvEmpleado" runat="server" Width="336px" 
            onselectedindexchanged="gvEmpleado_SelectedIndexChanged" 
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ButtonType="Image" 
                    SelectImageUrl="~/recursos/imagenes/seleccionar.jpg" ShowSelectButton="True">
                <ControlStyle Height="15px" Width="15px" />
                </asp:CommandField>
                <asp:BoundField DataField="cedula" HeaderText="CEDULA" />
                <asp:BoundField DataField="nombre" HeaderText="NOMBRE" />
                <asp:BoundField DataField="edad" HeaderText="EDAD" />
                <asp:BoundField DataField="trabajaEn" HeaderText="EMPRESA" />
                <asp:CheckBoxField DataField="casado" HeaderText="CASADO" />
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
        <br />
        <asp:Label ID="lblError" runat="server"></asp:Label><br />
        <br />
        <asp:LinkButton ID="lnkBtnVolver" runat="server" PostBackUrl="~/Default.aspx">Volver</asp:LinkButton>
    </div>
    </form>
</body>
</html>
