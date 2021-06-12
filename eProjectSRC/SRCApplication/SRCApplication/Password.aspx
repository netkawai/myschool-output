<%@ Page Language="C#" MasterPageFile="~/booking.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                Old Password</td>
        </tr>
        <tr>
            <td style="height: 17px">
                <input id="Password1" type="password" /></td>
        </tr>
        <tr>
            <td>
                New Password</td>
        </tr>
        <tr>
            <td>
                <input id="Text1" type="text" /></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Submit" />
            </td>
        </tr>
    </table>
</asp:Content>

