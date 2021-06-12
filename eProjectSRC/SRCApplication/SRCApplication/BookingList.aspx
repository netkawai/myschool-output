<%@ Page Language="C#" MasterPageFile="~/booking.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="refID" DataSourceID="BookingList" 
        ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="refID" HeaderText="refID" InsertVisible="False" 
                ReadOnly="True" SortExpression="refID" />
            <asp:BoundField DataField="bID" HeaderText="bID" SortExpression="bID" />
            <asp:BoundField DataField="eID" HeaderText="eID" SortExpression="eID" />
            <asp:BoundField DataField="cName" HeaderText="cName" SortExpression="cName" />
            <asp:BoundField DataField="cAge" HeaderText="cAge" SortExpression="cAge" />
            <asp:BoundField DataField="depDate" HeaderText="depDate" 
                SortExpression="depDate" />
            <asp:CommandField ShowEditButton="True" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <asp:SqlDataSource ID="BookingList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SRCConnection %>" 
        SelectCommand="SELECT * FROM [tBook]"></asp:SqlDataSource>
</asp:Content>

