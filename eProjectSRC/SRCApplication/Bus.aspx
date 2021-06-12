<%@ Page Language="C#" MasterPageFile="~/TRC.Master" AutoEventWireup="true" CodeBehind="Bus.aspx.cs" Inherits="WebApplication.Bus" Title="Bus List" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
  <form id="theForm" runat="server">
    <div id="table">

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" ShowFooter="True"
        DataKeyNames="bID" DataSourceID="SqlDataSourceBus" Width="587px">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:TemplateField HeaderText="bID" InsertVisible="False" SortExpression="bID">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("bID") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("bID") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:Button Text="Add" CommandName="Insert" OnCommand="GridView1_AddNew" CausesValidation="true" runat="server" ID="btInsert"/>&nbsp;
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="bName" SortExpression="bName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("bName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("bName") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="bNameBox" runat="server" Text='NewBus'></asp:TextBox>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="btName" SortExpression="btName">
                <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSubType"
                        DataTextField="btName" DataValueField="btID" SelectedValue='<%# Bind("bID") %>'>
                </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("btName") %>'></asp:Label>
                </ItemTemplate>

                <FooterTemplate>
                <asp:DropDownList ID="DropDownListAdd1" runat="server" 
                        DataSourceID="SqlDataSubType"
                        DataTextField="btName" DataValueField="btID">
                </asp:DropDownList>
                </FooterTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="bSeat" SortExpression="bSeat">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("bSeat") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("bSeat") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="bSeatBox" runat="server" Text='10'></asp:TextBox>
                </FooterTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="bDepart" SortExpression="bDepart">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("bDepart","{0:T}") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("bDepart", "{0:T}") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="bDepartBox" runat="server" Text='<%# Eval("1990-1-1 00:00", "{0:T}") %>'></asp:TextBox>
                </FooterTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="From_cName" SortExpression="From_cName">
                <EditItemTemplate>
                <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataSourceID="SqlDataSubCity"
                        DataTextField="cName" DataValueField="cID" SelectedValue='<%# Bind("From_cID") %>'>
                </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("From_cName") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:DropDownList ID="DropDownListAdd2" runat="server" 
                        DataSourceID="SqlDataSubCity"
                        DataTextField="cName" DataValueField="cID">
                </asp:DropDownList>
                </FooterTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="To_cName" SortExpression="To_cName">
                <EditItemTemplate>
                <asp:DropDownList ID="DropDownList3" runat="server" 
                        DataSourceID="SqlDataSubCity"
                        DataTextField="cName" DataValueField="cID" SelectedValue='<%# Bind("To_cID") %>'>
                </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("To_cName") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:DropDownList ID="DropDownListAdd3" runat="server" 
                        DataSourceID="SqlDataSubCity"
                        DataTextField="cName" DataValueField="cID">
                </asp:DropDownList>
                </FooterTemplate>
                
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceBus" runat="server" ConnectionString="<%$ ConnectionStrings:SRCConnection %>"
        SelectCommand="SELECT b.bID, b.bName, b.bType, b.bSeat, b.bDepart, b.From_cID, b.To_cID, t.btName, c1.cName AS From_cName, c2.cName AS To_cName FROM tBus AS b INNER JOIN tBusType AS t ON b.bType = t.btID INNER JOIN tCity AS c1 ON b.From_cID = c1.cID INNER JOIN tCity AS c2 ON b.To_cID = c2.cID"
        DeleteCommand="DELETE FROM [tBus] WHERE [bID] = @bID" InsertCommand="INSERT INTO [tBus] ([bName], [bType], [bSeat], [bDepart], [From_cID], [To_cID]) VALUES (@bName, @bType, @bSeat, @bDepart, @From_cID, @To_cID)" UpdateCommand="UPDATE [tBus] SET [bName] = @bName, [bType] = @bType, [bSeat] = @bSeat, [bDepart] = @bDepart, [From_cID] = @From_cID, [To_cID] = @To_cID WHERE [bID] = @bID">
        <DeleteParameters>
            <asp:Parameter Name="bID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="bName" Type="String" />
            <asp:Parameter Name="bType" Type="Int32" />
            <asp:Parameter Name="bSeat" Type="Int32" />
            <asp:Parameter DbType="DateTime" Name="bDepart" />
            <asp:Parameter Name="From_cID" Type="Int32" />
            <asp:Parameter Name="To_cID" Type="Int32" />
            <asp:Parameter Name="bID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="bName" Type="String" />
            <asp:Parameter Name="bType" Type="Int32" />
            <asp:Parameter Name="bSeat" Type="Int32" />
            <asp:Parameter DbType="DateTime" Name="bDepart"/>
            <asp:Parameter Name="From_cID" Type="Int32" />
            <asp:Parameter Name="To_cID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSubType" runat="server" ConnectionString="<%$ ConnectionStrings:SRCConnection %>"
        SelectCommand="SELECT [btID], [btName] FROM [tBusType]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSubCity" runat="server" ConnectionString="<%$ ConnectionStrings:SRCConnection %>"
        SelectCommand="SELECT [cID], [cName] FROM [tCity]"></asp:SqlDataSource>
    </div>
</form>
</asp:Content>
