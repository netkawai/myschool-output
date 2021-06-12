<%@ Page Language="C#" MasterPageFile="~/booking.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
            <table class="style1">
                <tr>
                    <td class="style4" style="width: 185px">
                        From :</td>
                    <td style="width: 216px">
                        To :</td>
                    <td>
                        Number of seat</td>
                </tr>
                <tr>
                    <td class="style5" style="width: 185px">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="CityList" 
                            DataTextField="cName" DataValueField="cName">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="CityList" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SRCConnection %>" 
                            SelectCommand="SELECT [cName] FROM [tCity]"></asp:SqlDataSource>
                    </td>
                    <td class="style3" style="width: 216px">
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="CityList" 
                            DataTextField="cName" DataValueField="cName">
                        </asp:DropDownList>
                    </td>
                    <td class="style3">
                        <asp:TextBox ID="TextBox3" runat="server" Width="30px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style6" style="width: 185px">
                        Date :</td>
                    <td class="style2" style="width: 216px">
                        Time :</td>
                    <td class="style2">
                        Bus Type</td>
                </tr>
                <tr>
                    <td class="style4" style="width: 185px">
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 216px">
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="TimeList" 
                            DataTextField="bDepart" DataValueField="bDepart">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="TimeList" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SRCConnection %>" 
                            SelectCommand="SELECT [bDepart] FROM [tBus]"></asp:SqlDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BusTypeList" 
                            DataTextField="btName" DataValueField="btName">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BusTypeList" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:SRCConnection %>" 
                            SelectCommand="SELECT [btName] FROM [tBusType]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="style4" style="width: 185px; height: 73px">
                        </td>
                    <td style="width: 216px; height: 73px">
                        </td>
                    <td style="height: 73px">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" />
                    </td>
                </tr>
            </table>
</asp:Content>

