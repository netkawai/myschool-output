<%@ Page Language="C#" MasterPageFile="~/Login.master" Title="Untitled Page" %>

<script runat="server">

    protected void LoginButton_Click(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <form id="form1" runat="server" style="height: 220px">
    <asp:Login ID="Login1" runat="server" Height="202px" Width="606px">
        <LayoutTemplate>
            <table border="0" cellpadding="1" cellspacing="0" 
                style="border-collapse:collapse;">
                <tr>
                    <td style="width: 310px">
                        <table border="0" cellpadding="0" style="height: 124px; width: 603px">
                            <tr>
                                <td style="text-align: center; height: 35px; width: 218px;">
                                    </td>
                                <td style="text-align: center; height: 35px; ">
                                    &nbsp;</td>
                                <td style="text-align: left; height: 35px; ">
                                    Log In</td>
                                <td style="text-align: center; height: 35px">
                                    </td>
                            </tr>
                            <tr>
                                <td style="height: 27px; width: 218px;">
                                </td>
                                <td style="height: 27px; width: 139px;">
                                    User Name:</td>
                                <td style="width: 478px; height: 27px;">
                                    <asp:TextBox ID="UserName" runat="server" Width="150px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                        ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                        ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="text-align: center; width: 314px; height: 27px">
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 27px; width: 218px;">
                                    &nbsp;</td>
                                <td style="height: 27px; width: 139px;">
                                    Password:</td>
                                <td style="width: 478px; height: 27px;">
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" 
                                        style="text-align: left" Width="150px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                        ControlToValidate="Password" ErrorMessage="Password is required." 
                                        ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="text-align: center; width: 314px; height: 27px">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 24px;">
                                    &nbsp;</td>
                                <td colspan="2" style="text-align: left; height: 24px;">
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="color:Red; height: 15px;">
                                    &nbsp;</td>
                                <td colspan="2" style="color:Red; height: 15px;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 28px;">
                                    &nbsp;</td>
                                <td colspan="2" style="text-align: left; height: 28px;">
                                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" 
                                        onclick="LoginButton_Click" Text="Log In" ValidationGroup="Login1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:Login>
    </form>
</asp:Content>

