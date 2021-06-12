<%@ Page Language="C#" MasterPageFile="~/booking.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 240px">
                Name :</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 240px">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
            <td>
                Mr. Samuel</td>
        </tr>
        <tr>
            <td style="width: 240px">
                Age :</td>
            <td>
                Bangalore - Chennai</td>
        </tr>
        <tr>
            <td style="width: 240px">
                <asp:TextBox ID="TextBox2" runat="server" Width="47px"></asp:TextBox>
            </td>
            <td>
                Bus No. : HN302</td>
        </tr>
        <tr>
            <td style="width: 240px; height: 120px">
                <asp:Button ID="ctnCal" runat="server" Text="Calculate" />
            </td>
            <td style="height: 120px">
                Seat : 1<br />
                Bus Type : Express<br />
                Ticket Type : Adult<br />
                Departure date : 1/2/2011 09:00<br />
                <br />
                <br />
                ---------------------------------------<br />
                Tax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                Rs 10<br />
                Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                Rs 120</td>
        </tr>
        <tr>
            <td style="width: 240px; height: 78px">
            </td>
            <td style="height: 78px">
                <asp:Button ID="Button1" runat="server" Text="Book" Width="58px" />
&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Text="Cancel" />
            </td>
        </tr>
    </table>
</asp:Content>

