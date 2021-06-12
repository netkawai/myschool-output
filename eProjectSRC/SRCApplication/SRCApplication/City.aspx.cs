using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Diagnostics;

namespace WebApplication
{
    public partial class City : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void gvCityResults_AddNew(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            if (e.CommandName == "Insert")
            {
                GridViewRow row = gvCityResults.FooterRow;

//              String strCustomerNumber = e.CommandArgument.ToString();
                SqlDataSourceCity.InsertParameters[0].DefaultValue = ((TextBox)row.Cells[2].Controls[0].FindControl("cNameBox")).Text;
                Debug.WriteLine(SqlDataSourceCity.InsertParameters[0].DefaultValue);
                SqlDataSourceCity.InsertParameters[1].DefaultValue = ((DropDownList)row.Cells[3].Controls[0].FindControl("ZoneList")).SelectedValue.ToString();
                SqlDataSourceCity.Insert();

                // After the order has been inserted, put the order in edit mode.
                gvCityResults.EditIndex = -1;
                gvCityResults.DataBind();
            }
        }

    }
}
